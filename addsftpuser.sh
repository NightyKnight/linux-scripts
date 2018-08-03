#!/bin/bash
# Script to add a user to Linux system
# -------------------------------------------------------------------------
# Copyright (c) 2007 nixCraft project <http://bash.cyberciti.biz/>
# This script is licensed under GNU GPL version 2.0 or above
# Comment/suggestion: <vivek at nixCraft DOT com>
# -------------------------------------------------------------------------
# See url for more info:
# http://www.cyberciti.biz/tips/howto-write-shell-script-to-add-user.html
# -------------------------------------------------------------------------
# Script for adding SFTP users. It will create the user, generate a password
# and lock them into the sftp jail.
# -------------------------------------------------------------------------
#check if username already exists
if [ $(id -u) -eq 0 ]; then
        read -p "Enter username : " username
        grep -E "^$username" /etc/passwd >/dev/null
        if [ $? -eq 0 ]; then
                        echo "$username exists!"
                 exit 1
        else
           	read -p "Enter customer ID: " customer
		read -p "Enter password: " password
        
		#Create the new user and add to the group sftponly and give the user no shell for security
		useradd -g sftponly -p $password -d /$customer -s /sbin/nologin -NM $username
        [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
                                mkdir /mnt/sftp/$username
                                mkdir /mnt/sftp/$username/$customer
                                chown $username:sftponly /mnt/sftp/$username/$customer
		#Encrypt user password
		echo $username:$password | chpasswd -c SHA512
        fi
else
        echo "Only root may add a user to the system"
        exit 2
fi
