#!/bin/bash

if [ ! -d ./forensic_log_website_daffainfo_log ] 
    then
        mkdir ./forensic_log_website_daffainfo_log
    else
        rm -rf ./forensic_log_website_daffainfo_log
	    mkdir ./forensic_log_website_daffainfo_log
fi

cat log_website_daffainfo.log | awk '{gsub(/"/, "", $1); print $1 }' | awk -F: '{gsub(/:/, " ", $1); arr[$3]++}
		END {
			for (i in arr) {
				count++
				res+=arr[i]
			}
			res=res/count
			printf "rata rata serangan perjam adalah sebanyak %.3f request per jam\n\n", res
		}' >> ./forensic_log_website_daffainfo_log/ratarata.txt

cat log_website_daffainfo.log | awk '{gsub(/,/, " ", $1); print $1 }' | awk -F: '{gsub(/:/, " ", $1); arr[$1]++}
    END {
        big=0
        flag
        for (i in arr) {
            if (big < arr[i]) {
                flag=i
                big=arr[flag]
            }
        }
        print "yang paling banyak mengakses server adalah: " flag " sebanyak " big " request\n"
    }' >> ./forensic_log_website_daffainfo_log/result.txt
    
cat log_website_daffainfo.log | awk '/curl/ { ++n } END {
    print "ada " n " request yang menggunakan curl sebagai user-agent\n"}' >> ./forensic_log_website_daffainfo_log/result.txt

cat log_website_daffainfo.log | awk -F: '/2022:02/ {gsub(/"/, "", $1) arr[$1]++ }
    END {
        for (i in arr) {
            print i " mengakses website pada jam 2 pagi"
        }
     }' >> ./forensic_log_website_daffainfo_log/result.txt
