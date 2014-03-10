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

### Step 2 : launch the virtual machine
````sh
cd vagrant
vagrant up
```` 

Vagrant and puppet provisionning should take a while at the first launch.
When the machine is ready, just do :

````sh
vagrant ssh
````

And you should access to the machine in ssh.

### Step 3 : configure the host to have access to the machine

//TODO : configurer fichier hosts


## Custonize settings

- Change the default OS : TODO


