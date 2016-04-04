#!/bin/bash
set -e

# Dependencies

echo "Installing dependencies..."
# sudo yum -y update
sudo yum install -y wget
# sudo yum install -y git

# Python

echo "Installing Python dependencies..."
sudo yum install -y python-setuptools gcc python-devel libffi-devel openssl-devel
sudo easy_install pip

echo "Installing Riak Python client..."
sudo pip install riak

# Java

echo "Downloading Java package..."
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.rpm"

echo "Installing Java package..."
sudo rpm -ivh jdk-8u45-linux-x64.rpm

echo "Downloading and installing JARs..."
wget http://riak-java-client.s3.amazonaws.com/riak-client-2.0.3-jar-with-dependencies.jar
wget http://www.slf4j.org/dist/slf4j-1.7.12.tar.gz
tar -xvf slf4j-1.7.12.tar.gz

# Erlang

# echo "Installing Erlang dependencies..."
# sudo yum install -y autoconf gcc-c++ ncurses-devel openssl-devel glibc-devel pam-devel patch

# curl -O https://raw.githubusercontent.com/yrashk/kerl/master/kerl
# chmod a+x kerl
# export CFLAGS="-DOPENSSL_NO_EC=1"
# KERL_CONFIGURE_OPTIONS='--disable-hipe --enable-smp-support --enable-threads --enable-kernel-poll --without-odbc'

# echo "Building Erlang..."
# ./kerl build git git://github.com/basho/otp.git OTP_R16B02_basho9 OTP_R16B02_basho9
# ./kerl install OTP_R16B02_basho9 .kerl/builds/OTP_R16B02_basho9

# echo "Installing Erlang client..."
# git clone git://github.com/basho/riak-erlang-client.git
# cd riak-erlang-client
# git checkout tags/2.2.0-timeseries
# make

# Examples

mkdir ~/examples

echo "Downloading sample data..."
wget https://s3.amazonaws.com/files.basho.com/demos/time_series/all-data-2.tar.gz
tar -xvf all-data-2.tar.gz
mv all-data-2.csv examples/data.csv
rm all-data-2.tar.gz

