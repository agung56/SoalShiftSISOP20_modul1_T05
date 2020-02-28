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
#### Soal 3.b
```bash
# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command
#* 0-14,19-23 * * * ls /home/lab/Downloads > /home/lab/log/"date".txt

5 6-23/8 * * 0-5 /bin/bash /home/lab/Downloads/modul1/soal3/soal3.sh
```

#### Soal 3.c
```bash
#!/bin/bash

kenangan=`mkdir kenangan`
duplicate=`mkdir duplicate`

coba=`ls | grep "pdkt_kusuma_" | cut -d "_" -f 3 | sort -n | tail -1`

arr=""
for ((i=1;i<=coba;i=i+1))
do
lokasi=`cat wget.log | grep "Location" | head -$i | tail -1 | cut -d " "  -f 2`
duplikat=`echo -e $arr | awk -v loc=$lokasi 'BEGIN{duplikatlagi=0}{if(loc==$0) duplikatlagi=1} END {printf "%d", duplikatlagi}'`


if [[ $duplikat == 0 ]]
then

arr="$arr$lokasi\n"
mv pdkt_kusuma_$i kenangan/kenangan_$i
else
mv pdkt_kusuma_$i duplicate/duplicate_$i
fi
done

cat wget.log >> wget.log.bak
rm wget.log
```

# Pembahasan Nomor 1


> ## #Script untuk 1 A
>
**A=`awk -F '\t' 'NR>1{region[$13]+=$21} END{for( i in region) printf "%s,%f\n",i , region[i]}' Sample-Superstore.tsv | sort -g -t"," -k 2 | awk -F "," 'NR<2 {printf "%s\n", $1 }'`
echo $A
echo""**



## Penjelasan Script


>**A=awk -F '\t' 'NR>1{region[$13]+=$21} END{for( i in region) printf "%s,%f\n",i , region[i]}' Sample-Superstore.tsv**>

Variabel A diinisiasi dan dilakukan fungsi awk, dan untuk -F '\t' merupakan syntax untuk separator awk sesuai dengan format file .tsv , selanjutnya untuk fungsi NR>1 yaitu melihat dari Row (baris) lebih dari satu yang dimana baris petama tidak dihitung. untuk command **{region[$13]+=$21} END{for( i in region)** selanjutnya merupakan pengecekan pada kolom ke 21 yang dimana hasilnya akan dijumlahkan dan digunakan bersamaan dengan kolomg ke 13 pada variabel region. selanjutnya adalah hasil di print yaitu hasil pertama berupa string / **%s** dan hasil kedua berupa fold / **%f**, dan dipisahkan dengan tanda koma. command terakhir pada line ini adalah memasukkan file yang akan dieksekusi sesuai dengan command sebelumnya yaitu pada file **Sample-Superstore.tsv**.

>**|  sort -g -t"," -k 2**>

selanjutnya dari hasil tersebut akan muncul output berupa nama state beserta profit yang sudah ditambahkan dan dipisahkan dengan tanda koma **' , '**. selanjutnya akan dilakukan sorting  dengan menggunakan command **-g** yaitu sorting numeric dan **-t** yaitu separator atau pemisah yang dimana menggunakan pemisah koma **' , '**. selanjutnya akan dilakukan adalah syntax **-k 2** yaitu mengambil key atau kunci variabel kedua yang dipisah pada dengan tanda koma, artinya yang diambil adalah angkanya karena output pada proses sebelumnya adalah **Region,xxxxx (angka)**. yang dimana angka tersebut yang dijadikan patokan untuk command selanjutnya.

>**| awk -F "," 'NR<2 {printf "%s\n", $1 }'**>
>**echo $A**
>**echo ""**

selanjutnya dari hasil command sebelumnya, akan dilanjutkan dengan command **awk -F"," ** yaitu command awk dan -F sebagai separator dan tanda koma sebagai separator yang diinput. setelah itu untuk command **NR<2 {printf "%s\n", $1 }'** karena yang ingin ditampilkan adalah baris pertama yaitu yang memiliki profit terkecil maka yang dilakukan adalah memilih number of rows kurang dari 2, yaitu **row pertama**, dan melakukan printf yaitu menampilkan **string** pada variable pertama antara pemisah yaitu variable state. **misal : Central,XXXX** maka yang akan ditampilkan pada akhirnya adalah **Central**. dan langkah terakhir adalah mencetak $A yaitu merupakan fungsi keseluruhan. dan **echo ""** berfungsi untuk memberikan space berupa line space (enter)

> ## #Script untuk 1 B
>
**B=`awk -F "\t" -v A=$A 'NR>1{if($13~A)check[$11]+=$21} END{for(i in check) printf "%s,%f\n",i, check[i]}' Sample-Superstore.tsv | sort -g -t"," -k 2 | awk -F "," 'NR<3 {printf "%s\n", $1 }'`
C1=`echo $B | awk -F " " '{printf $1}'`
C2=`echo $B | awk -F " " '{printf $2}'`
echo $C1 $C2
echo""**



## Penjelasan Script


>**B=`awk -F "\t" -v A=$A 'NR>1{if($13~A)check[$11]+=$21} END{for(i in check) printf "%s,%f\n",i, check[i]}' Sample-Superstore.tsv**>

Variabel B diinisiasi dan dilakukan fungsi awk, dan untuk -F '\t' merupakan syntax untuk separator awk sesuai dengan format file .tsv , lalu untuk **-v A=$A** adalah pemanggilan variabel sebelumnya yaitu $A yang dijadikan untuk patokan pada soal 1b. selanjutnya untuk fungsi NR>1 yaitu melihat dari Row (baris) lebih dari satu yang dimana baris petama tidak dihitung. lalu untuk **{if($13~A)check[$11]+=$21} END{for( i in check)** akan dicek bahwa jika pada kolom ke 13 adalah variabel A yang merupakan region central, maka variabel check diminta untuk melihat kolom 21 dan kolom 11 untuk dijumlahkan dan dijadikan satu jika ada yang msama.  selanjutnya adalah hasil di print yaitu hasil pertama berupa string / **%s** dan hasil kedua berupa fold / **%f**, dan dipisahkan dengan tanda koma. command terakhir pada line ini adalah memasukkan file yang akan dieksekusi sesuai dengan command sebelumnya yaitu pada file **Sample-Superstore.tsv**.

>**|  sort -g -t"," -k 2**>

selanjutnya dari hasil tersebut akan muncul output berupa nama state beserta profit yang sudah ditambahkan dan dipisahkan dengan tanda koma **' , '**. selanjutnya akan dilakukan sorting  dengan menggunakan command **-g** yaitu sorting numeric dan **-t** yaitu separator atau pemisah yang dimana menggunakan pemisah koma **' , '**. selanjutnya akan dilakukan adalah syntax **-k 2** yaitu mengambil key atau kunci variabel kedua yang dipisah pada dengan tanda koma, artinya yang diambil adalah angkanya karena output pada proses sebelumnya adalah **State,xxxxx (angka)**. yang dimana angka tersebut yang dijadikan patokan untuk command selanjutnya.

>**| awk -F "," 'NR<3 {printf "%s\n", $1 }'`**>

selanjutnya dari hasil command sebelumnya, akan dilanjutkan dengan command **awk -F"," ** yaitu command awk dan -F sebagai separator dan tanda koma sebagai separator yang diinput. setelah itu untuk command **NR<3 {printf "%s\n", $1 }'** karena yang ingin ditampilkan adalah baris 2 baris pertama yaitu yang memiliki profit terkecil maka yang dilakukan adalah memilih number of rows kurang dari 3, yaitu **row pertama dan kedua**, dan melakukan printf yaitu menampilkan **string** pada variable pertama antara pemisah yaitu variable state. **misal : Texas,XXXX** maka yang akan ditampilkan pada akhirnya adalah **Texas**

>**C1=`echo $B | awk -F " " '{printf $1}'`
C2=`echo $B | awk -F " " '{printf $2}'`
echo $C1 $C2
echo""**>

selanjutnya adalah memasukkan variabel $B yaitu variabel pertamanya menjadi C1 yang dimana akan digunakan untuk soal 1c selanjutnya, begitu juga untuk variabel C2, hanya saja yang membedakan adalah yang dimasukkan ke C2 adalah variabel kedua dari $B karea hasil dari $B adalah **XXXX YYYY**

> ## #Script untuk 1 C
>
**awk -F "\t" -v C= $C1 -v D= $C2 '{if (match ($11,C)||match ($11,D)) seen[$17]+=$NF} END{for(i in seen) printf "%s,%f\n",i, seen[i]}' Sample-Superstore.tsv | sort -g -t"," -k 2 | awk -F "," 'NR<11 {printf "%s\n", $1 }'**

**echo ""**



## Penjelasan Script


>**awk -F "\t" -v C=$C1 -v D=$C2 '{if (match ($11,C)||match ($11,D)) seen[$17]+=$NF} END{for(i in seen) printf "%s,%f\n",i, seen[i]}' Sample-Superstore.tsv**>

Menggunakan fungsi awk, dan untuk -F '\t' merupakan syntax untuk separator awk sesuai dengan format file .tsv , lalu untuk **-v C=$C1** **-v D=C2** adalah pemanggilan variabel sebelumnya yaitu $C1 dan $C2 yang dijadikan untuk patokan pada soal 1b. selanjutnya untuk **'{if (match ($11,C)||match ($11,D)) seen[$17]+=$NF} END{for(i in seen)** akan dilakukan pengecekan untuk variabel C atau D apakah ada yang sama pada kolom ke 11, jika ada maka lanjut ke proses selanjutnya yang dimana melihat kolom ke 17 untuk dijadikan patokan produknya.  selanjutnya adalah hasil di print yaitu hasil pertama berupa string / **%s** dan hasil kedua berupa fold / **%f**, dan dipisahkan dengan tanda koma. command terakhir pada line ini adalah memasukkan file yang akan dieksekusi sesuai dengan command sebelumnya yaitu pada file **Sample-Superstore.tsv**.

>**| sort -g -t"," -k 2**>

selanjutnya dari hasil tersebut akan muncul output berupa nama state beserta profit yang sudah ditambahkan dan dipisahkan dengan tanda koma **' , '**. selanjutnya akan dilakukan sorting  dengan menggunakan command **-g** yaitu sorting numeric dan **-t** yaitu separator atau pemisah yang dimana menggunakan pemisah koma **' , '**. selanjutnya akan dilakukan adalah syntax **-k 2** yaitu mengambil key atau kunci variabel kedua yang dipisah pada dengan tanda koma, artinya yang diambil adalah angkanya karena output pada proses sebelumnya adalah **Produk,xxxxx (angka)**. yang dimana angka tersebut yang dijadikan patokan untuk command selanjutnya.

>**awk -F "," 'NR<11 {printf "%s\n", $1 }**>

selanjutnya dari hasil command sebelumnya, akan dilanjutkan dengan command **awk -F"," ** yaitu command awk dan -F sebagai separator dan tanda koma sebagai separator yang diinput. setelah itu untuk command **NR<11 {printf "%s\n", $1 }'** karena yang ingin ditampilkan adalah baris 10 baris pertama yaitu yang memiliki profit terkecil maka yang dilakukan adalah memilih number of rows kurang dari 11, yaitu **row pertama sampai ke sepuluh**, dan melakukan printf yaitu menampilkan **string** yang diambil dari nama produk

# Pembahasan Nomor 2


> ## #Script untuk 2 A
>
**#!/bin/bash**
**password=`cat /dev/urandom | tr -d -c 'A-Za-z0-9' | fold -w 28 | head -n 1**
**filename=`echo $1 | tr -d -c 'A-Za-z'**`

**echo $password > $filename.txt**



## Penjelasan Script


>**password=`cat /dev/urandom**>

membuat variabel password dan didalamnya menggunakan dev/urandom yang dimana dev/urandom ini merupakan sejenis library bawaan dari linux untuk membuat karakter random (semua karakter baik angka, simbol, huruf, dll**.

>**| tr -d -c 'A-Za-z0-9'**>

selanjutnya dari hasil tersebut maka akan dilakukan translate dengan commantd **tr** yang dimana translate akan membuat suatu infinite looping menggunakan semua karakter dengan urandom sebelumnya sehingga perlu dilakukan command selanjutnya untuk memenuhi keperluan untuk isi password, command **-d dan -c** adalah command untuk delete dan complement atau **"hapus kecuali"**, sehingga semua karakter yang di translate tadi akan dihapus kecuali **'A-Za-z0-9'** yaitu permintaan dari soal

>**| fold -w 28 | head -n 1**>

lalu dari translate tersebut dilakukan command fold untuk mengambil karakter dan dengan command **-w 28** yang artinya diambil karakter selebar **width** 28  karakter dan diambil hanya bagian **head atau paling atas** saja karena jika tidak diambil maka tetap yang ditampilkan adalah infinite loop tersebut dengan 28 karakter kesamping dan tidak ada batasan bawahnya maka dari itu dilakukan pengambilan head.

>**filename=`echo $1 | tr -d -c 'A-Za-z'**>

yang selanjutnya adalah dengan membuat variabel filename untuk nama file dengan cara **translate** yang sama dengan proses sebelumnya akan tetapi yang membedakan adalah yang dilakukan **hapus kecuali** hanyalah huruf kecil dan kapital (sesuai soal).

>**echo $password > $filename.txt**>

lalu yang terakhir adalah memasukkan variabel **password** tadi ke dalam suatu file dengan nama sesuai dengan variabel **filename** tadi dan dengan ekstensi **.txt**
