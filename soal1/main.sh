#!/bin/bash

read -p "Username: " username
read -s -p "Password: " password

echo ""
heyo=$(awk -v var="$username" -v vir="$password" '{ if( $1==var && $2==vir ) printf "%s\n", $1}' users/user.txt)
# echo $heyo


len=`expr "$heyo" : '.*'`
# echo $len
hitung=1
if [ $len -gt 0 ] ; 
then
    echo "$(date +%D) $(date +%T) LOGIN: INFO User $username logged in">> users/log.txt
    while [ true ]
    do
        read -p "$ " perintah banyak
        if [ "$perintah" == "dl" ]
        then
            if [ ! -d ./$(date +"%Y-%m-%d")_$username ] 
            then
                mkdir ./$(date +"%Y-%m-%d")_$username  
            fi

            if [ -f ./$(date +"%Y-%m-%d")_$username/$(date +"%Y-%m-%d")_$username.zip ]
            then
                unzip -P $password ./$(date +"%Y-%m-%d")_$username/$(date +"%Y-%m-%d")_$username.zip
                hitung="$(zipinfo -h ./$(date +"%Y-%m-%d")_$username/$(date +"%Y-%m-%d")_$username.zip | tr '\n' ':' | awk -F ':'  '{print $5}')"
                hitung=$((hitung+1))
                rm ./$(date +"%Y-%m-%d")_$username/*.zip
                hitung=$((hitung-1))
            fi

            for ((i=1; i<=$banyak; i+=1))
            do
                wget -O - https://loremflickr.com/320/240 >> ./$(date +"%Y-%m-%d")_$username/PIC_$hitung
                echo $hitung
                hitung=$((hitung+1))
            done

            zip -P "$password" -r "./$(date +"%Y-%m-%d")_$username/$(date +"%Y-%m-%d")_$username" $(date +"%Y-%m-%d")_$username
            rm -rf ./$(date +"%Y-%m-%d")_$username/*PIC_* 

        elif [[ "$perintah" == "att" && "$banyak" == "" ]]
        then
            awk -v u="LOGIN: INFO User $username logged in" '
            $0~u { n++ }
            END { print "success login attempt is ", n, "time(s)" }
        ' users/log.txt
        
        awk -v u="LOGIN: ERROR Failed login attempt on user $username" '
            $0~u { n++ }
            END { print "failed login attempt is ", n, "time(s)" }
        ' users/log.txt
        elif [[ "$perintah" == "exit" && "$banyak" == "" ]]
        then
            break
        else
            print "Please try again \n"
        fi
    done
else
    echo "$(date +%D) $(date +%T) LOGIN: ERROR Failed login attempt on user $username">> users/log.txt
fi