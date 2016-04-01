# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.env.enable

  if ENV['VAGRANT_OS'] == 'UBUNTU' 
      config.vm.box = "ubuntu/trusty64"
      config.vm.provision "shell", path: "bootstrap-ubuntu.sh", args: ["#{ENV['VAGRANT_OS']}", "#{ENV['KEY_PATH']}", "#{ENV['AWS_ACCESS_KEY']}", "#{ENV['AWS_SECRET_KEY']}"]
  else
      config.vm.box = "puphpet/centos65-x64"
      config.vm.provision "shell", path: "bootstrap-rhel.sh", args: "#{ENV['VAGRANT_OS']} #{ENV['KEY_PATH']} #{ENV['AWS_ACCESS_KEY']} #{ENV['AWS_SECRET_KEY']}" 
  end

  config.vm.synced_folder "aws/", "/home/vagrant/aws"
  
  if defined? ENV['KEY_PATH']
     file_name = File.basename("#{ENV['KEY_PATH']}")
     config.vm.provision "file", source: ENV['KEY_PATH'], destination: "/home/vagrant/.ssh/" + file_name
  end

  config.vm.provision "shell", inline: "echo 'export PATH=\"$PATH\":/home/vagrant' >> /home/vagrant/.bashrc"

end
