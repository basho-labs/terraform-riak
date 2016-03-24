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

echo 'export PATH="$PATH":/home/vagrant' | tee --append /home/vagrant/.bashrc
