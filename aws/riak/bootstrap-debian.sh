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
