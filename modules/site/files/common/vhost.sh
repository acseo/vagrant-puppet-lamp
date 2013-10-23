#!/bin/bash

if ! [ $(id -u) = 0 ]; then
   echo "You must be root to do this." 1>&2
   exit 1
fi

read -p "Site name: " site

rootdir="/vagrant/"
sitedir=$rootdir$site

#/etc/hosts
cp /etc/hosts /etc/hosts.original
echo -e "127.0.0.1\t$site" >> /etc/hosts

mkdir -p "$sitedir" 

VHOSTSFILE="/etc/apache2/sites-available/$site"
echo "<VirtualHost *:80>" >> $VHOSTSFILE
echo -e "\tDocumentRoot \"${sitedir}/public/\"" >> $VHOSTSFILE
echo -e "\tServerName ${site}" >> $VHOSTSFILE
echo -e "" >> $VHOSTSFILE
echo -e "\t<Directory ${sitedir}/public>" >> $VHOSTSFILE
echo -e "\t\tOptions Indexes FollowSymlinks MultiViews" >> $VHOSTSFILE
echo -e "\t\tAllowOverride All" >> $VHOSTSFILE
echo -e "\t\tOrder allow,deny" >> $VHOSTSFILE
echo -e "\t\tallow from all" >> $VHOSTSFILE
echo -e "\t\tEnableMMAP Off" >> $VHOSTSFILE
echo -e "\t\tEnableSendfile Off" >> $VHOSTSFILE
echo -e "\t</Directory>" >> $VHOSTSFILE
echo '</VirtualHost>' >> $VHOSTSFILE

a2ensite $site
/etc/init.d/apache2 reload
