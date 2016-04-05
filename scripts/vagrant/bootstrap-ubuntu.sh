#!/bin/bash
set -e

if [ -n "$1" ]; then
  PROVIDER=$1
  VAGRANT_OS="UBUNTU"
  if [ $PROVIDER == "AWS" ]; then
    KEY_PATH=$2
    AWS_ACCESS_KEY=$3
    AWS_SECRET_KEY=$4
  elif [ $PROVIDER == "DIGITAL_OCEAN" ]; then
    echo "provider: Digital Ocean"
    echo $PROVIDER
    DO_TOKEN=$2
    DO_PUB_KEY_PATH=$3
    DO_PVT_KEY_PATH=$4
    DO_FINGERPRINT=$5
  fi
fi

echo "Installing dependencies..."
# sudo apt-get update
sudo apt-get install -y wget unzip git python-setuptools
# sudo apt-get install -y gcc python-devel
sudo easy_install pip
sudo pip install paramiko PyYAML Jinja2 httplib2 six

echo "Installing Terraform..."
wget https://releases.hashicorp.com/terraform/0.6.14/terraform_0.6.14_linux_amd64.zip
unzip terraform_0.6.14_linux_amd64.zip

echo "Installing Ansible..."
git clone git://github.com/ansible/ansible.git --recursive

if [ $PROVIDER == "AWS" ]; then

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

elif [ $PROVIDER == "DIGITAL_OCEAN" ]; then

  echo "Updating Digital Ocean configs..."

  PUB_KEY_NAME=$(basename $DO_PUB_KEY_PATH)
  PVT_KEY_NAME=$(basename $DO_PVT_KEY_PATH)

  sed -i "44s/.*/    default = \"$DO_TOKEN\"/" $PWD/digital-ocean/global.tf
  if [ -n "$VAGRANT_OS"  ]; then
    sed -i "49s~.*~    default = \"/home/vagrant/.ssh/$PUB_KEY_NAME\"~" $PWD/digital-ocean/global.tf
    sed -i "54s~.*~    default = \"/home/vagrant/.ssh/$PVT_KEY_NAME\"~" $PWD/digital-ocean/global.tf
  else
    sed -i "49s~.*~    default = \"$DO_PUB_KEY_PATH\"~" $PWD/digital-ocean/global.tf
    sed -i "54s~.*~    default = \"$DO_PVT_KEY_PATH\"~" $PWD/digital-ocean/global.tf
  fi
  sed -i "59s/.*/    default = \"$DO_FINGERPRINT\"/" $PWD/digital-ocean/global.tf
fi

