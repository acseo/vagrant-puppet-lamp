# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "Debian_7.3_32"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/debian-73-i386-virtualbox-puppet.box"

  config.vm.synced_folder "../", "/var/www/project"

  config.vm.provider :virtualbox do |vb|
  	vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.network "private_network", ip: "192.168.10.10"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path = "modules"
    puppet.manifest_file  = "site.pp"
  end
  
end