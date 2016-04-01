#!/bin/bash
set -e

# Dependencies

echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -f
sudo dpkg --configure -a
sudo apt-get install -y wget git

# Python

echo "Installing Python dependencies..."
sudo apt-get install -y python-setuptools python-dev libffi-dev libssl-dev
sudo easy_install pip

echo "Installing Riak Python client..."
sudo pip install riak

# Java

# echo "Downloading Java package..."
wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u5-b13/jdk-8u5-linux-x64.tar.gz

# echo "Installing Java package..."
sudo mkdir /opt/jdk
sudo tar -zxf jdk-8u5-linux-x64.tar.gz -C /opt/jdk

sudo update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_05/bin/java 100
sudo update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_05/bin/javac 100

sudo update-alternatives --display java
sudo update-alternatives --display javac

java -version

echo "Downloading and installing JARs..."
wget http://riak-java-client.s3.amazonaws.com/riak-client-2.0.3-jar-with-dependencies.jar
wget http://www.slf4j.org/dist/slf4j-1.7.12.tar.gz
tar -xvf slf4j-1.7.12.tar.gz

# Erlang

# echo "Installing Erlang client dependencies..."
# sudo apt-get install -y erlang-parsetools erlang-dev erlang-syntax-tools
# sudo apt-get install -y make

# echo "Cloning Erlang client repo..."
# git clone git://github.com/basho/riak-erlang-client.git
# cd riak-erlang-client
# git checkout tags/2.2.0-timeseries

# echo "Building Erlang client..."
# make
