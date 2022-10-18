#!/bin/bash

# admin config
read -p 'Enter Admin Username: ' admin_u
read -sp 'Enter Admin Password: ' admin_p

# server list (add more if necessary)
svr1="<svr IP>"
svr2="<svr IP>"
svr3="<svr IP>"

options=($svr1 $svr2 $svr3 "Quit")

while getopts u:p:g: flag

do
    case "${flag}" in
        u) username=${OPTARG};;
        p) password=${OPTARG};;
        g) groups=${OPTARG};;
    esac
done

echo ""
echo "Username: $username"
echo "groups: $groups"
echo ""

select opt in "${options[@]}"
do 
    case $opt in
        $svr1)
            sshpass -p $admin_p ssh $admin_u@$svr1 "sudo useradd -m $username; echo -e '$password\n$password' | sudo passwd $username; sudo usermod -a -G $groups $username; sudo usermod -s /bin/bash $username; echo $CONDA_SETUP >> ~/.bashrc"
            sshpass -p $password ssh $username@$svr1 "conda init bash"
            ;;
        $svr2)
            sshpass -p $admin_p ssh $admin_u@$svr2 "sudo useradd -m $username; echo -e '$password\n$password' | sudo passwd $username; sudo usermod -a -G $groups $username; sudo usermod -s /bin/bash $username;"
            sshpass -p $password ssh $username@$svr2 "conda init bash"
            ;;
        $svr3)
            sshpass -p $admin_p ssh $admin_u@$svr3 "sudo useradd -m $username; echo -e '$password\n$password' | sudo passwd $username; sudo usermod -a -G $groups $username; sudo usermod -s /bin/bash $username;"
            sshpass -p $password ssh $username@$svr3 "conda init bash"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
