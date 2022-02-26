#!bin/bash

while :
do
	if [ ! $(date '+%M' ) == '59' ]
	then
		current_date=$(date "+%Y%m%d%H")
		list_files=$(ls log/metrics_$current_date*)

		for FILE in $list_files 
		do
			cat $FILE | grep -v mem >> dummy.txt
		done

		awk -F, ' BEGIN {
			min_mem_total=99999
			max_mem_total=0
			sum_mem_total=0

			min_mem_used=99999
			max_mem_used=0
			sum_mem_used=0

			min_mem_free=99999
			max_mem_free=0
			sum_mem_free=0

			min_mem_shared=99999
			max_mem_shared=0
			sum_mem_shared=0

			min_mem_buff=99999
			max_mem_buff=0
			sum_mem_buff=0

			min_mem_avaiable=99999
			max_mem_avaiable=0
			sum_mem_avaiable=0

			min_swap_total=99999
			max_swap_total=0
			sum_swap_total=0	

			min_swap_used=99999
			max_swap_used=0
			sum_swap_used=0

			min_swap_free=99999
			max_swap_free=0
			sum_swap_free=0

			min_path_size=99999
			max_path_size=0
			sum_path_size=0
			
			cnt=0
			}
			{
			if (min_mem_total > $1) min_mem_total=$1
			if (max_mem_total < $1) max_mem_total=$1
			sum_mem_total=sum_mem_total+$1
			
			if (min_mem_used > $2) min_mem_used=$2
			if (max_mem_used < $2) max_mem_used=$2
			sum_mem_used=sum_mem_used+$2

			if (min_mem_free > $3) min_mem_free=$3
			if (max_mem_free < $3) max_mem_free=$3
			sum_mem_free=sum_mem_free+$3

			if (min_mem_shared > $4) min_mem_shared=$4
			if (max_mem_shared < $4) max_mem_shared=$4
			sum_mem_shared=sum_mem_shared+$4

			if (min_mem_buff > $5) min_mem_buff=$5
			if (max_mem_buff < $5) max_mem_buff=$5
			sum_mem_buff=sum_mem_buff+$5

			if (min_mem_avaiable > $6) min_mem_avaiable=$6
			if (max_mem_avaiable < $6) max_mem_avaiable=$6
			sum_mem_avaiable=sum_mem_avaiable+$6

			if (min_swap_total > $7) min_swap_total=$7
			if (max_swap_total < $7) max_swap_total=$7
			sum_swap_total=sum_swap_total+$7

			if (min_swap_used > $8) min_swap_used=$8
			if (max_swap_used < $8) max_swap_used=$8
			sum_swap_used=sum_swap_used+$8

			if (min_swap_free > $9) min_swap_free=$9
			if (max_swap_free < $9) max_swap_free=$9
			sum_swap_free=sum_swap_free+$9

			if (min_path_size > $11) min_path_size=$11
			if (max_path_size < $11) max_path_size=$11
			sum_path_size=sum_path_size+$11
			
			cnt=cnt+1
			path=$10
			}
			END { 
			
			avg_mem_total=int(sum_mem_total/cnt)
			avg_mem_used=int(sum_mem_used/cnt)
			avg_mem_free=int(sum_mem_free/cnt)
			avg_mem_buff=int(sum_mem_buff/cnt)
			avg_mem_shared=int(sum_mem_shared/cnt)
			avg_mem_avaiable=int(sum_mem_avaiable/cnt)
			avg_swap_total=int(sum_swap_total/cnt)
			avg_swap_free=int(sum_swap_free/cnt)
			avg_swap_used=int(sum_swap_used/cnt)
			avg_path_size=int(sum_path_size/cnt)
			
			print "type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size\nminimum,"min_mem_total","min_mem_used",",min_mem_free","min_mem_shared","min_mem_buff","min_mem_avaiable","min_swap_total","min_swap_used","min_swap_free","path","min_path_size "\nmaximum,"max_mem_total","max_mem_used","max_mem_free","max_mem_shared","max_mem_buff","max_mem_avaiable","max_swap_total","max_swap_used","max_swap_free","path","max_path_size, "\naverage,"avg_mem_total","avg_mem_used","avg_mem_free","avg_mem_shared","avg_mem_buff","avg_mem_avaiable","avg_swap_total","avg_swap_used","avg_swap_free","path","avg_path_sizes "M\n" 
			} 
		' dummy.txt >> log/metrics_agg_$current_date.log
			chmod 700 log/metrics_agg_$current_date.log
		rm dummy.txt
		  	
	sleep 3600
	fi
done
