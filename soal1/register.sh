#!/bin/bash

read -p "Username: " username
read -s -p "Password: " password

check_username() {
    #echo "$1 $2"
    len="${#password}"
    #echo "$len"
    if test $len -ge 8 ; then
        if ! [[ "$password" =~ [^a-zA-Z0-9\ ] ]]; then
           echo "$password" | grep -q [A-Z]
                if test $? -eq 0 ; then
                    echo "$password" | grep -q [a-z]   
                        if test $? -eq 0 ; then
                            if [[ "$password" != "$username" ]] ; then
                                heyo=$(awk -v var="$username" '{ if( $1==var) printf "%s\n", $1}' users/user.txt)
                                #echo $heyo
                                lena=`expr "$heyo" : '.*'`
                                #echo $lena
                                if [ $lena -gt 0 ] ; 
                                then
                                    echo "$(date +%D) $(date +%T) REGISTER: $username is already exist" >> users/log.txt
                                else
                                    echo "$username $password" >> users/user.txt
                                    echo "$(date +%D) $(date +%T) REGISTER: INFO User $username registered successfully" >> users/log.txt
                                fi
                            else 
                                echo "$(date +%D) $(date +%T) REGISTER: username dan password cannot be the same" >> users/log.txt
                            fi
                        else
                            echo "$(date +%D) $(date +%T) REGISTER: password  must include lower case">> users/log.txt
                        fi
                else
                    echo "$(date +%D) $(date +%T) REGISTER password must include uppper case" >> users/log.txt
                fi
        else
            echo "$(date +%D) $(date +%T) password must use alphanumeric"  >> users/log.txt
        fi

    else
        echo "$(date +%D) $(date +%T) password lenght should be greater than or equal 8" >> users/log.txt
    fi
}   

if [ ! -d ./users ] 
    then
        mkdir ./users 
fi

check_username $username $password

