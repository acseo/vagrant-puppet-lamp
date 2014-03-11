# Vagrant / Puppet / Lamp provisionning

This Project provide files that can be used to create de Web Developpement environnement thanks to Vagrant and Puppet.

## Requirements
- Vagrant (http://www.vagrantup.com/)
- A virtualization solution (such as VirtualBox : https://www.virtualbox.org/)

## How to use it

### Step 1 : add project in your environment
If your project is already versionned using git : 

````sh
cd /path/to/myproject 
git submodule add vagrant https://github.com/acseo/vagrant-puppet-lamp.git
````

This command should create a vagrant folder in your project folder

### Step 2 : Use the setup script to configure Vagrant and Puppet
By default, the Vagrantfile and manifests/site.pp files are not present. You can use our tool to generate them (based on hidden files .Vagrantfile and manifests/.site.pp) :
````sh
cd /path/to/myproject/vagrant
./setup.sh
````
Just answer the questions or leave default value. 
At the end of the script, configuration files for Vagrant and Puppet should be generated !

### Step 3 : launch the virtual machine and provision
````sh
cd vagrant
vagrant up
vagrant provision
```` 

Vagrant and puppet provisionning should take a while at the first launch.
When the machine is ready, just do :

````sh
vagrant ssh
````
And you should access to the machine in ssh.

