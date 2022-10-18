#!/bin/bash

# admin config
read -p 'Enter Admin Username: ' admin_u
read -sp 'Enter Admin Password: ' admin_p

# server list
svr1="<svr IP>"
svr2="<svr IP>"
svr3="<svr IP>"

options=($svr1 $svr2 $svr3)

while getopts u:p: flag

do
    case "${flag}" in
        u) username=${OPTARG};;
        p) password=${OPTARG};;
        # g) groups=${OPTARG};;
    esac
done
echo "Username: $username"
echo "password: $password"
# echo "groups: $groups"

for i in ${options[@]};
do
    # login with admin account
    sshpass -p $admin_p ssh $admin_u@$i "echo -e '$password\n$password' | sudo passwd $username;"

    # # commands for reset password
    # # commands cannot be run here as it will 
    # # be running after ssh has ended
    # sudo passwd $username

done