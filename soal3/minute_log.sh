#!bin/bash

if [ ! -d log ] 
then
	mkdir log
fi

mem=$(free -m| grep "Mem" | awk '{ print  $2","$3","$4","$5","$6","$7 } ')
swap=$(free -m| grep "Swap" | awk '{ print $2 "," $3 "," $4}')
saya=$(whoami)
path="/home/$saya"
disk=$(du -sh /home/$saya | awk '{print $1}')
hasil="${mem},${swap},${path},${disk}"
FILE=log/metrics_$( date "+%Y%m%d%H%M" ).log
printf  "mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size\n$hasil\n"  >> $FILE
chmod 700 $FILE
