#!/bin/bash

if [[ -f ./Vagrantfile || -f ./manifests/site.pp ]]
then
    echo "The file ./Vagrantfile or ./manifests/site.pp already exist."
    echo "You must delete them in order to continue"
    exit -1
fi
## Default values
GUEST_IP_ADDRESS=192.168.10.10
APACHE_PROJECT_PATH=/var/www/project
APACHE_PROJECT_WEB_PATH=/var/www/project/web
APACHE_HOST_NAME=project.local
MYSQL_ROOT_PASSWORD=root
MYSQL_DB_NAME=project_db
MYSQL_USER=project_user
MYSQL_PASSWORD=project_password

## Prompt
echo -n "Please enter the guest IP address (default : $GUEST_IP_ADDRESS): "
read NEW_GUEST_IP_ADDRESS
[ -n "$NEW_GUEST_IP_ADDRESS" ] && GUEST_IP_ADDRESS=$NEW_GUEST_IP_ADDRESS

echo -n "Please enter the guest project path (default : $APACHE_PROJECT_PATH): "
read NEW_APACHE_PROJECT_PATH
[ -n "$NEW_APACHE_PROJECT_PATH" ] && APACHE_PROJECT_PATH=$NEW_APACHE_PROJECT_PATH

echo -n "Please enter the guest project web path (default : $APACHE_PROJECT_WEB_PATH): "
read NEW_APACHE_PROJECT_WEB_PATH
[ -n "$NEW_APACHE_PROJECT_WEB_PATH" ] && APACHE_PROJECT_WEB_PATH=$NEW_APACHE_PROJECT_WEB_PATH

echo -n "Please enter the website local name (default : $APACHE_HOST_NAME): "
read NEW_APACHE_HOST_NAME
[ -n "$NEW_APACHE_HOST_NAME" ] && APACHE_HOST_NAME=$NEW_APACHE_HOST_NAME

echo -n "Please enter the MySQL root password (default : $MYSQL_ROOT_PASSWORD): "
read NEW_MYSQL_ROOT_PASSWORD
[ -n "$NEW_MYSQL_ROOT_PASSWORD" ] && MYSQL_ROOT_PASSWORD=$NEW_MYSQL_ROOT_PASSWORD

echo -n "Please enter the MySQL database name (default : $MYSQL_DB_NAME): "
read NEW_MYSQL_DB_NAME
[ -n "$NEW_MYSQL_DB_NAME" ] && MYSQL_DB_NAME=$NEW_MYSQL_DB_NAME

echo -n "Please enter the MySQL database user (default : $MYSQL_USER): "
read NEW_MYSQL_USER
[ -n "$NEW_MYSQL_USER" ] && MYSQL_USER=$NEW_MYSQL_USER

echo -n "Please enter the MySQL database password (default : $MYSQL_PASSWORD): "
read NEW_MYSQL_PASSWORD
[ -n "$NEW_MYSQL_PASSWORD" ] && MYSQL_PASSWORD=$NEW_MYSQL_PASSWORD


## Copy dot files
echo -n "Copying ./.Vagrantfile in ./Vagrantfile... "
cp ./.Vagrantfile ./Vagrantfile
echo "OK"
echo -n "Copying ./manifests/.site.pp in ./manifests/site.pp... "
cp ./manifests/.site.pp ./manifests/site.pp
echo "OK"

echo "Setting user values in configuration files... "
sed -i "s,{{APACHE_PROJECT_PATH}},$APACHE_PROJECT_PATH,g" ./Vagrantfile
sed -i "s,{{APACHE_PROJECT_PATH}},$APACHE_PROJECT_PATH,g" ./manifests/site.pp

sed -i "s,{{APACHE_PROJECT_WEB_PATH}},$APACHE_PROJECT_WEB_PATH,g" ./Vagrantfile
sed -i "s,{{APACHE_PROJECT_WEB_PATH}},$APACHE_PROJECT_WEB_PATH,g" ./manifests/site.pp

sed -i "s,{{GUEST_IP_ADDRESS}},$GUEST_IP_ADDRESS,g" ./Vagrantfile
sed -i "s,{{GUEST_IP_ADDRESS}},$GUEST_IP_ADDRESS,g" ./manifests/site.pp

sed -i "s,{{APACHE_HOST_NAME}},$APACHE_HOST_NAME,g" ./Vagrantfile
sed -i "s,{{APACHE_HOST_NAME}},$APACHE_HOST_NAME,g" ./manifests/site.pp

sed -i "s,{{MYSQL_ROOT_PASSWORD}},$MYSQL_ROOT_PASSWORD,g" ./Vagrantfile
sed -i "s,{{MYSQL_ROOT_PASSWORD}},$MYSQL_ROOT_PASSWORD,g" ./manifests/site.pp

sed -i "s,{{MYSQL_DB_NAME}},$MYSQL_DB_NAME,g" ./Vagrantfile
sed -i "s,{{MYSQL_DB_NAME}},$MYSQL_DB_NAME,g" ./manifests/site.pp

sed -i "s,{{MYSQL_USER}},$MYSQL_USER,g" ./Vagrantfile
sed -i "s,{{MYSQL_USER}},$MYSQL_USER,g" ./manifests/site.pp

sed -i "s,{{MYSQL_PASSWORD}},$MYSQL_PASSWORD,g" ./Vagrantfile
sed -i "s,{{MYSQL_PASSWORD}},$MYSQL_PASSWORD,g" ./manifests/site.pp
echo "OK"

echo ""
echo "Done !"
echo ""
echo "Vagrant and Puppet are now ready to use"
echo "You can launch vagrant by using the command : vagrant up"
exit 0