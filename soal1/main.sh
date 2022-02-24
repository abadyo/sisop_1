#!/bin/bash

read username
read -s password


heyo=$(awk -v var="$username" -v vir="$password" '{ if( $1==var && $2==vir ) printf "%s\n", $1}' users/user.txt)
# echo $heyo


len=`expr "$heyo" : '.*'`
# echo $len
if [ $len -gt 0 ] ; 
then
    echo "$(date +%D) $(date +%T)  LOGIN: INFO User $username logged in">> users/log.txt
    #sisinya perintah dl sama ngelog
else
    echo "$(date +%D) $(date +%T) LOGIN: ERROR Failed login attempt on user $username">> users/log.txt
fi