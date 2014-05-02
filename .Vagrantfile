# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu-1310-i386"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-1310-i386-virtualbox-puppet.box"

  config.vm.synced_folder "../", "{{APACHE_PROJECT_PATH}}"

  config.vm.provider :virtualbox do |vb|
  	vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.network "private_network", ip: "{{GUEST_IP_ADDRESS}}"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path = "modules"
    puppet.manifest_file  = "site.pp"
  end
  
end