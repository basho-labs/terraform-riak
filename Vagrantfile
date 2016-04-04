# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.env.enable

  if ENV['VAGRANT_OS'] == 'UBUNTU' 
      config.vm.box = "ubuntu/trusty64"
      bootstrap_file = "bootstrap-ubuntu.sh"
  else
      config.vm.box = "puphpet/centos65-x64"
      bootstrap_file = "bootstrap-rhel.sh"
  end

  if ENV['PROVIDER'] == 'AWS'
      config.vm.provision "shell", path: "scripts/vagrant/" + bootstrap_file, args: ["AWS", "#{ENV['KEY_PATH']}", "#{ENV['AWS_ACCESS_KEY']}", "#{ENV['AWS_SECRET_KEY']}"]
      config.vm.synced_folder "aws/", "/home/vagrant/aws"
      key_name = File.basename("#{ENV['AWS_KEY_PATH']}")
      config.vm.provision "file", source: ENV['AWS_KEY_PATH'], destination: "/home/vagrant/.ssh/" + key_name
  elsif ENV['PROVIDER'] == 'DIGITAL_OCEAN'
      config.vm.provision "shell", path: "scripts/vagrant/" + bootstrap_file, args: ["DIGITAL_OCEAN", "#{ENV['DO_TOKEN']}", "#{ENV['DO_PUB_KEY_PATH']}", "#{ENV['DO_PVT_KEY_PATH']}", "#{ENV['DO_FINGERPRINT']}"]
      config.vm.synced_folder "digital-ocean/", "/home/vagrant/digital-ocean"
      pub_key_name = File.basename("#{ENV['DO_PUB_KEY_PATH']}")
      pvt_key_name = File.basename("#{ENV['DO_PVT_KEY_PATH']}")
      config.vm.provision "file", source: ENV['DO_PUB_KEY_PATH'], destination: "/home/vagrant/.ssh/" + pub_key_name
      config.vm.provision "file", source: ENV['DO_PVT_KEY_PATH'], destination: "/home/vagrant/.ssh/" + pvt_key_name
  end

  config.vm.provision "shell", inline: "echo 'export PATH=\"$PATH\":/home/vagrant' >> /home/vagrant/.bashrc"

end
