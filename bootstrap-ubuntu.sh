#!/bin/bash
set -e

if [ -n "$1" ]; then
  VAGRANT_OS=$1
  KEY_PATH=$2
  AWS_ACCESS_KEY=$3
  AWS_SECRET_KEY=$4
fi

echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -y wget unzip git g++ python-dev python-setuptools
sudo easy_install pip
sudo pip install paramiko PyYAML Jinja2 httplib2 six

echo "Installing Terraform..."
wget https://releases.hashicorp.com/terraform/0.6.14/terraform_0.6.14_linux_amd64.zip
unzip terraform_0.6.14_linux_amd64.zip

echo "Installing Ansible..."
git clone git://github.com/ansible/ansible.git --recursive

echo "Updating AWS configs..."

KEY_NAME1=$(basename $KEY_PATH)
KEY_NAME2=${KEY_NAME1%.*}

sed -i "47s/.*/    default = \"$KEY_NAME2\"/" $PWD/aws/global.tf
if [ -n "$VAGRANT_OS"  ]; then
  sed -i "52s~.*~    default = \"/home/vagrant/.ssh/$KEY_NAME1\"~" $PWD/aws/global.tf
else
  sed -i "52s~.*~    default = \"$KEY_PATH\"~" $PWD/aws/global.tf
fi
sed -i "57s/.*/    default = \"$AWS_ACCESS_KEY\"/" $PWD/aws/global.tf
sed -i "62s~.*~    default = \"$AWS_SECRET_KEY\"~" $PWD/aws/global.tf
