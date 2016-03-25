#!/bin/bash
set -e

echo "Installing dependencies..."
sudo yum install -y wget unzip git gcc python-devel
sudo easy_install pip
sudo pip install paramiko PyYAML Jinja2 httplib2 six

echo "Installing Terraform..."
wget https://releases.hashicorp.com/terraform/0.6.8/terraform_0.6.8_linux_amd64.zip
unzip terraform_0.6.8_linux_amd64.zip

echo "Installing Ansible..."
git clone git://github.com/ansible/ansible.git --recursive

echo "Updating AWS configs..."
KEY_PATH=$(sed '1q;d' aws.conf | cut -d '=' -f 2)
KEY_NAME=$(basename $KEY_PATH)
KEY_NAME=${KEY_NAME%.*}
AWS_ACCESS_KEY=$(sed '2q;d' aws.conf | cut -d '=' -f 2)
AWS_SECRET_KEY=$(sed '3q;d' aws.conf | cut -d '=' -f 2)

sed -i "47s/.*/    default = \"$KEY_NAME\"/" aws/global.tf
sed -i "52s~.*~    default = \"/home/vagrant/.ssh/$KEY_NAME\"~" aws/global.tf
sed -i "57s/.*/    default = \"$AWS_ACCESS_KEY\"/" aws/global.tf
sed -i "62s~.*~    default = \"$AWS_SECRET_KEY\"~" aws/global.tf

rm aws.conf

# Recreate symlinks
rm aws/riak/global_variables.tf
rm aws/clients/global_variables.tf
rm aws/security/global_variables.tf
ln -s ../global.tf aws/riak/global_variables.tf
ln -s ../global.tf aws/clients/global_variables.tf
ln -s ../global.tf aws/security/global_variables.tf

echo 'export PATH="$PATH":/home/vagrant' | tee --append /home/vagrant/.bashrc
