# soal-shift-siop-modul-1-IT13-2022

Sisop modul 1

# Soal 2

Pembahasan soal no 2


## Pembahasan soal

Membuat soal script yang menscan file log dari website [berikut](https://daffa.info). 
1. Periksa apakah folder/directory  forensic_log_website_daffainfo_log 
```bash
if [ ! -d ./ forensic_log_website_daffainfo_log ] then
    mkdir ./ forensic_log_website_daffainfo_log
fi
```
2. Untuk mencari rata-rata, ambil string jam tiap request. lalu masukkan ke dalam array  tiap jam. Saat dimasukkan, tambah nilai 1. Kemudian lakukan loop untuk menghitung banyak jam dan menjumlah total akses tiap jam. Kemudian bagi jumlah akses dengan total jam untuk mencari rata-rata. Output dimasukkan ke dalam rata-rata.txt.
```bash
#menghitung banyak akses tiap jam
awk '{gsub(/"/, "", $1); print $1 }' | awk -F: '{gsub(/:/, " ", $1); arr[$3]++}

#menghitung rata-rata
END {
			for (i in arr) {
				count++
				res+=arr[i]
			}
			res=res/count
			printf "rata rata serangan perjam adalah sebanyak %.3f request per jam\n\n", res
		}'
```
3. Untuk mencari IP address terbanyak, ambil string IP address pertama. lalu masukkan ke dalam string, yang mana akan tambah satu tiap string sama ditemukan. Lalu melakukan algoritma menemukan nilai terbesar dalam array.
```bash
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
```
4. Untuk mencari curl, tinggal mencari kata kunci curl dengan awk.
```bash
cat log_website_daffainfo.log | awk '/curl/ { ++n } END
```
5. Untuk melihat ip address yang mengakses pa jam 2 pagi, mengambil string jam. Lalu masukkan ke dalam array. lalu print array yang mengakses pada pukul 2 pagi.
```bash
cat log_website_daffainfo.log | awk -F: '/2022:02/ {gsub(/"/, "", $1) arr[$1]++ }
``` 

## Kendala yang dialami
Awal-awal masih tidak tahu cara mengakses log di website, tetapi baru ditemukan file lognya H-1.
