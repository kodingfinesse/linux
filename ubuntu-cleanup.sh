#!/bin/sh

#Check the Drive Space Used by Cached Files
du -sh /var/cache/apt/archives

#Clean all the log file
#for logs in `find /var/log -type f`;  do > $logs; done

logs=`find /var/log -type f`
for i in $logs
do
> $i
done

#Getting rid of partial packages
apt-get clean && apt-get autoclean
apt-get remove --purge -y software-properties-common

#Getting rid of no longer required packages
apt-get autoremove -y


#Getting rid of orphaned packages
deborphan | xargs sudo apt-get -y remove --purge

#Free up space by clean out the cached packages
apt-get clean

# Remove the Trash
rm -rf /home/*/.local/share/Trash/*/**
rm -rf /root/.local/share/Trash/*/**

# Remove Man
rm -rf /usr/share/man/?? 
rm -rf /usr/share/man/??_*

#Delete all .gz and rotated file
find /var/log -type f -regex ".*\.gz$" | xargs rm -Rf
find /var/log -type f -regex ".*\.[0-9]$" | xargs rm -Rf

#Cleaning is completed
echo "Cleaning is completed"
