# SoalShiftSISOP20_modul1_T05
#### Anggota Kelompok:
1. I Gede Pradhana Indra W. (05311840000031)
2. Agung Mulyono            (05311840000035)


## Soal 1
### Deskripsi
Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum untuk membuat laporan berdasarkan data yang ada pada file "Sample-Superstore.csv". Namun dia tidak dapat meyelesaikan tugas tersebut. Laporan yang diminta berupa:

**a**. Tentukan wilayah bagian (state) yang memiliki keuntungan (profit) paling sedikit.

**b**. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin a.

**c**. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin b.

### Pembahasan
```bash
#!/bin/bash

#untuk nomor 1a
A=`awk -F '\t' 'NR>1{region[$13]+=$21} END{for( i in region) printf "%s,%f\n",i , region[i]}' Sample-Superstore.tsv | sort -g -t"," -k 2 | awk -F "," 'NR<2 {printf "%s\n", $1 }'`
echo $A
echo""


#untuk nomor 1b
B=`awk -F "\t" -v A=$A 'NR>1{if($13~A)check[$11]+=$21} END{for(i in check) printf "%s,%f\n",i, check[i]}' Sample-Superstore.tsv | sort -g -t"," -k 2 | awk -F "," 'NR<3 {printf "%s\n", $1 }'`
C1=`echo $B | awk -F " " '{printf $1}'`
C2=`echo $B | awk -F " " '{printf $2}'`
echo $C1 $C2
echo""


#untuk nomor 1c

awk -F "\t" -v C=$C1 'NR>1{if($11~C)check[$17]+=$21} END{for(i in check) printf "%s,%f\n",i, check[i]}' Sample-Superstore.tsv | sort -g -t"," -k 2 | awk -F "," 'NR<11 {printf "%s\n", $1 }'
echo ""
awk -F "\t" -v D=$C2 'NR>1{if($11~D)check[$17]+=$21} END{for(i in check) printf "%s,%f\n",i, check[i]}' Sample-Superstore.tsv | sort -g -t"," -k 2 | awk -F "," 'NR<11 {printf "%s\n", $1 }'
```

## Soal2
### Deskripsi
**a**. Membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 kaeakter yang terdapat huruf besar, huruf kecil, angka.

**b**. Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang diinputkan dan **HANYA berupa alphabet**.

**c**. Kemudian supaya **file.txt** tersebut tidak mudah diketahui maka nama filenya akan dienkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam (0-23) dibuatnya file tersebut dengan program terpisah

**d**. Membuat script untuk mendekripsi file yang telah di enkrip

### Pembahasan

#### Soa1 2.a
```bash
#!/bin/bash
password=`cat /dev/urandom | tr -d -c 'A-Za-z0-9' | fold -w 28 | head -n 1`
filename=`echo $1 | tr -d -c 'A-Za-z'`
echo $password > $filename.txt
```

#### Soal 2.c
```bash
#!/bin/bash

for tajuk in $@
do
time=`date +%H -r $tajuk`
tajuklama=`basename $tajuk .txt`

tajukbaru=`echo $tajuklama | caesar $time`
mv $tajuk $tajukbaru.txt
done
```
#### Soal 2.d
```bash
#!/bin/bash

for tajuk in $@
do
jam=`date +%H -r $tajuk`
tajuklama=`basename $tajuk .txt`
jambaru=`expr 26 - $jam`
tajukbaru=`echo $tajuklama | caesar $jambaru`
mv $tajuk $tajukbaru.txt
done
```

## Soal 3
### Deskripsi
**a**. Membuat script untuk mendownload 28 gambar dari "https://loremflickr.com/320/240/cat" menggunakan command **wget** dan menyimpan file dengan nama "pdkt_kusuma_NO" serta menyimpan **log message wget** kedalam sebuah file "wget.log"

**b**. Membuat crontab download file **setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari sabtu**

**c**. Membuat script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate dengan format filename "duplicate_nomor". Setelah itu lakukan pemindahan semua gambar yang tersisa ke dalam folder ./kenangan dengan format filename "kenangan_nomor". Setelah tidak ada gambar di *current directory*, maka lakukan backup seluruh log menjadi ekstensi ".log.bak".

### Pembahasan

#### Soal 3.a
```bash
#!/bin/bash

#untuk mengambil 28 gambar berbeda dan dengan nama akhir berbeda
for gambar in {1..28}
do
wget "https://loremflickr.com/320/240/cat" -a wget.log -O "pdkt_kusuma_$gambar"
done
```
