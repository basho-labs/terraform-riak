# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.env.enable

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "centos/7"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provision "file", source: "aws", destination: "/home/vagrant"
  config.vm.provision "file", source: ".env", destination: "/home/vagrant/aws.conf"
  config.vm.provision "shell", path: "setup.sh"
  file_name = File.basename ENV['KEY_PATH']
  config.vm.provision "file", source: ENV['KEY_PATH'], destination: "/home/vagrant/.ssh/" + file_name

end
