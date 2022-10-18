# Servers Adminstrative Scripts

These adminstrative scripts were written to ease the workload of engineers whenever they need to onboard/dismiss staff

add user: `bash ./add_user.sh -u <username> -p <password> -g <group name>`

```
1) <svr IP>  3) <svr IP>  
2) <svr IP>	 4) Quit
#? 
```

Just choose the server you want to add the user into or quit

remove user: `bash ./remove_user.sh -u <username>`

adjust groups: `bash ./adjust_groups.sh -u <username> -g <group name 1>,<group name 2>`

reset password: `bash ./reset_password.sh -u <username> -p <new password>`


