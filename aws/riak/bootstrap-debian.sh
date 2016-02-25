#!/bin/bash
set -e

echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -y curl

# Set the local private ip
LOCAL_IP=$(curl http://instance-data/latest/meta-data/local-ipv4)

# Read the package path
PACKAGE=$(cat /tmp/package | tr -d '\n')
PACKAGE_FILE_NAME=$(basename $PACKAGE)

echo "Fetching Riak..."
wget $PACKAGE

echo "Installing Riak..."
sudo dpkg -i $PACKAGE_FILE_NAME 

echo "Set Riak to start on boot"
sudo update-rc.d riak defaults

echo "Setting ulimit..."
echo 'riak soft nofile 65536' | sudo tee --append /etc/security/limits.conf
echo 'riak hard nofile 65536' | sudo tee --append /etc/security/limits.conf
echo "$USER soft nofile 65536" | sudo tee --append /etc/security/limits.conf
echo "$USER hard nofile 65536" | sudo tee --append /etc/security/limits.conf
echo "session required pam_limits.so" | sudo tee --append /etc/pam.d/common-session

echo "Configuring Riak..."
echo "nodename = riak@$LOCAL_IP" | sudo tee --append /etc/riak/riak.conf
echo "listener.http.internal = $LOCAL_IP:8098" | sudo tee --append /etc/riak/riak.conf
echo "listener.protobuf.internal = $LOCAL_IP:8087" | sudo tee --append /etc/riak/riak.conf

echo "Starting Riak..."
sudo riak start
sudo riak ping

# Create scripts sub-directory
mkdir ~/scripts

# Setting up intra-cluster ssh
if [ -f $HOME/.ssh/id_rsa.pub ]; then
    cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
fi

# Update riak_shell
if [ -f /tmp/cluster ]; then
    echo "Updating riak_shell config..."
    CLUSTER=$(cat /tmp/cluster)
    NODES=$(cat /tmp/cluster | tr ^ ' ' | sed "s/,/ /g" | sed "s/riak@//g")
    if [ -f /etc/riak/riak_shell.config ]; then
        sudo mv /etc/riak/riak_shell.config /etc/riak/riak_shell.config.org
        sed "s/'riak@127.0.0.1'/$CLUSTER/g" /etc/riak/riak_shell.config.org  | tr ^ \' | sudo tee /etc/riak/riak_shell.config
        cat<<DONE > /tmp/sftp.batch
lcd /etc/riak
cd /tmp
put riak_shell.config
DONE
        for i in $NODES; do
            echo "Updating riak_shell.config on $i"
            sftp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -b /tmp/sftp.batch $i
            ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $i "sudo mv /tmp/riak_shell.config /etc/riak; sudo chown riak:riak /etc/riak/riak_shell.config"
        done
    fi
fi
