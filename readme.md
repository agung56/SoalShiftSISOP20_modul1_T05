# SoalShiftSISOP20_modul1_T05
#### Anggota Kelompok:
1. I Gede Pradhana Indra W. (05311840000031)
2. Agung Mulyono            (05311840000035)


## Soal 1
### Deskripsi Soal
Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum untuk membuat laporan berdasarkan data yang ada pada file "Sample-Superstore.csv". Namun dia tidak dapat meyelesaikan tugas tersebut. Laporan yang diminta berupa:

**A**. Tentukan wilayah bagian (state) yang memiliki keuntungan (profit) paling sedikit.

**B**. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin A.

**C**. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin B.

### Pembahasan
Code : https://github.com/agung56/SoalShiftSISOP20_modul1_T05/blob/master/soal1/soal1.sh

* Script untuk 1 A
```
A=`awk -F '\t' 'NR>1{region[$13]+=$21} END{for( i in region) printf "%s,%f\n",i , region[i]}' Sample-Superstore.tsv | sort -g -t"," -k 2 | awk -F "," 'NR<2 {printf "%s\n", $1 }'`
echo $A
echo""
```
**Penjelasan Script**

`A=awk -F '\t' 'NR>1{region[$13]+=$21} END{for( i in region) printf "%s,%f\n",i , region[i]}' Sample-Superstore.tsv`

Variabel A diinisiasi dan dilakukan fungsi awk, dan untuk -F '\t' merupakan *syntax* untuk *separator* awk sesuai dengan format file .tsv , selanjutnya untuk fungsi **NR>1** yaitu melihat dari *Row* (baris) lebih dari satu yang dimana baris pertama tidak dihitung. Untuk *command* `{region[$13]+=$21} END{for( i in region)` selanjutnya merupakan pengecekan pada kolom ke 21 yang dimana hasilnya akan dijumlahkan dan digunakan bersamaan dengan kolom ke 13 pada variabel *region*. Selanjutnya adalah hasil di print yaitu hasil pertama berupa *string* (**%s**) dan hasil kedua berupa *float* (**%f**) yang dipisahkan dengan tanda koma (,). *Command* terakhir pada line ini adalah memasukkan file yang akan dieksekusi sesuai dengan *command* sebelumnya yaitu pada file **Sample-Superstore.tsv**.

`|  sort -g -t"," -k 2`

Selanjutnya dari hasil tersebut akan muncul *output* berupa nama *state* beserta profit yang sudah ditambahkan dan dipisahkan dengan tanda koma **' , '**. Selanjutnya akan dilakukan pengurutan (*sorting*)  dengan menggunakan *command* **-g** yaitu *sorting numeric* dan **-t** yaitu pemisah (*separator*) yang dimana menggunakan pemisah koma **' , '**. Selanjutnya akan dilakukan adalah *syntax* **-k 2** yaitu mengambil kunci (*key*) variabel kedua yang dipisah pada dengan tanda koma, artinya yang diambil adalah angkanya karena *output* pada proses sebelumnya adalah **Region,xxxxx (angka)** yang dimana angka tersebut yang dijadikan patokan untuk *command* selanjutnya.

`| awk -F "," 'NR<2 {printf "%s\n", $1 }'
echo $A
echo ""`

Selanjutnya dari hasil *command* sebelumnya, akan dilanjutkan dengan *command* `awk -F","` yaitu *command* awk dan -F sebagai pemisah (*separator*) dan tanda koma sebagai pemisah yang diinput. Setelah itu untuk *command* `NR<2 {printf "%s\n", $1 }` karena yang ingin ditampilkan adalah baris pertama yaitu yang memiliki profit terkecil maka yang dilakukan adalah memilih *number of rows* kurang dari 2, yaitu **row pertama**, dan melakukan printf yaitu menampilkan **string** pada variabel pertama antara pemisah yaitu *variable state*. **misal : Central,XXXX** maka yang akan ditampilkan pada akhirnya adalah **Central**. dan langkah terakhir adalah mencetak **$A** yaitu merupakan fungsi keseluruhan. dan **echo ""** berfungsi untuk memberikan spasi (jarak) berupa enter.

* Script untuk 1 B
```
B=`awk -F "\t" -v A=$A 'NR>1{if($13~A)check[$11]+=$21} END{for(i in check) printf "%s,%f\n",i, check[i]}' Sample-Superstore.tsv | sort -g -t"," -k 2 | awk -F "," 'NR<3 {printf "%s\n", $1 }'`
C1=`echo $B | awk -F " " '{printf $1}'`
C2=`echo $B | awk -F " " '{printf $2}'`
echo $C1 $C2
echo""
```
 **Penjelasan Script**
 
`B=awk -F "\t" -v A=$A 'NR>1{if($13~A)check[$11]+=$21} END{for(i in check) printf "%s,%f\n",i, check[i]}' Sample-Superstore.tsv`

Variabel B diinisiasi dan dilakukan fungsi awk, dan untuk -F '\t' merupakan *syntax* untuk pemisah (*separator*) awk sesuai dengan format file .tsv , lalu untuk **-v A=$A** adalah pemanggilan variabel sebelumnya yaitu **$A** yang dijadikan untuk patokan pada soal 1B. Selanjutnya untuk fungsi **NR>1** yaitu melihat dari baris (*Row*) lebih dari satu yang dimana baris pertama tidak dihitung. Lalu untuk `{if($13~A)check[$11]+=$21} END{for( i in check)` akan dicek bahwa jika pada kolom ke 13 adalah variabel A yang merupakan *region central*, maka variabel **check** diminta untuk melihat kolom 21 dan kolom 11 untuk dijumlahkan dan dijadikan satu jika ada yang sama. Selanjutnya adalah hasil diprint yaitu hasil pertama berupa *string* (**%s**) dan hasil kedua berupa *float* (**%f**) dan dipisahkan dengan tanda koma. *Command* terakhir pada line ini adalah memasukkan file yang akan dieksekusi sesuai dengan command sebelumnya yaitu pada file **Sample-Superstore.tsv**.

`|  sort -g -t"," -k 2`

Selanjutnya dari hasil tersebut akan muncul keluaran (*output*) berupa nama *state* beserta profit yang sudah ditambahkan dan dipisahkan dengan tanda koma **' , '**. Selanjutnya akan dilakukan pengurutan (*sorting*)  dengan menggunakan *command* **-g** yaitu *sorting numeric* dan **-t** yaitu pemisah (*separator*) yang dimana menggunakan pemisah koma **' , '**. Selanjutnya akan dilakukan adalah *syntax* **-k 2** yaitu mengambil kunci (*key*) variabel kedua yang dipisah pada dengan tanda koma, artinya yang diambil adalah angkanya karena *output* pada proses sebelumnya adalah **State,xxxxx (angka)**. yang dimana angka tersebut yang dijadikan patokan untuk *command* selanjutnya.

`| awk -F "," 'NR<3 {printf "%s\n", $1 }'`

Selanjutnya dari hasil *command* sebelumnya, akan dilanjutkan dengan *command* **awk -F","** yaitu *command* awk dan -F sebagai pemisah (*separator*) dan tanda koma sebagai pemisah yang diinput. setelah itu untuk *command* `NR<3 {printf "%s\n", $1 }'` karena yang ingin ditampilkan 2 baris pertama yaitu yang memiliki profit terkecil maka yang dilakukan adalah memilih *number of rows* kurang dari 3, yaitu **row pertama dan kedua**, dan melakukan **printf** yaitu menampilkan **string** pada variable pertama antara pemisah yaitu variabel *state*. **misal : Texas,XXXX** maka yang akan ditampilkan pada akhirnya adalah **Texas**

`C1=echo $B | awk -F " " '{printf $1}'
C2=echo $B | awk -F " " '{printf $2}'
echo $C1 $C2
echo""`

Selanjutnya adalah memasukkan variabel **$B** yaitu variabel pertamanya menjadi C1 yang dimana akan digunakan untuk soal 1C selanjutnya, begitu juga untuk variabel C2, hanya saja yang membedakan adalah yang dimasukkan ke C2 adalah variabel kedua dari **$B** karena hasil dari **$B** adalah **XXXX YYYY**

* Script untuk 1 C
```
awk -F "\t" -v C= $C1 -v D= $C2 '{if (match ($11,C)||match ($11,D)) seen[$17]+=$NF} END{for(i in seen) printf "%s,%f\n",i, seen[i]}' Sample-Superstore.tsv | sort -g -t"," -k 2 | awk -F "," 'NR<11 {printf "%s\n", $1 }'
echo ""
```

**Penjelasan Script**

`awk -F "\t" -v C=$C1 -v D=$C2 '{if (match ($11,C)||match ($11,D)) seen[$17]+=$NF} END{for(i in seen) printf "%s,%f\n",i, seen[i]}' Sample-Superstore.tsv`

Menggunakan fungsi awk, dan untuk **-F '\t'** merupakan *syntax* untuk pemisah (*separator*) awk sesuai dengan format file .tsv , lalu untuk `-v C=$C1** **-v D=C2` adalah pemanggilan variabel sebelumnya yaitu **$C1** dan **$C2** yang dijadikan untuk patokan pada soal 1B. Selanjutnya untuk `'{if (match ($11,C)||match ($11,D)) seen[$17]+=$NF} END{for(i in seen)` akan dilakukan pengecekan untuk variabel C atau D apakah ada yang sama pada kolom ke 11, jika ada maka lanjut ke proses selanjutnya yang dimana melihat kolom ke 17 untuk dijadikan patokan produknya.  Selanjutnya adalah hasil diprint yaitu hasil pertama berupa *string* (**%s**) dan hasil kedua berupa *float* (**%f**) dan dipisahkan dengan tanda koma(,). *Command* terakhir pada baris ini adalah memasukkan file yang akan dieksekusi sesuai dengan *command* sebelumnya yaitu pada file **Sample-Superstore.tsv**.

`| sort -g -t"," -k 2`

Selanjutnya dari hasil tersebut akan muncul *output* berupa nama *state* beserta profit yang sudah ditambahkan dan dipisahkan dengan tanda koma **' , '**. Selanjutnya akan dilakukan pengurutan (*sorting*)  dengan menggunakan *command* **-g** yaitu *sorting numeric* dan **-t** yaitu pemisah (*separator*) yang dimana menggunakan pemisah koma **' , '**. Kemudian *syntax* **-k 2** digunakan untuk mengambil *key* atau kunci variabel kedua yang dipisah pada dengan tanda koma, artinya yang diambil adalah angkanya karena *output* pada proses sebelumnya adalah **Produk,xxxxx (angka)** yang dimana angka tersebut yang dijadikan patokan untuk *command selanjutnya*.

`awk -F "," 'NR<11 {printf "%s\n", $1 }`

Selanjutnya dari hasil *command* sebelumnya, akan dilanjutkan dengan *command* **awk -F","** yaitu *command* awk dan -F sebagai pemisah (*separator*) dan tanda koma sebagai pemisah yang diinput. Setelah itu untuk *command* `NR<11 {printf "%s\n", $1 }'` karena yang ingin ditampilkan 10 baris pertama yaitu yang memiliki profit terkecil maka yang dilakukan adalah memilih *number of rows* kurang dari 11, yaitu **row pertama sampai ke sepuluh**, dan melakukan printf yaitu menampilkan **string** yang diambil dari nama produk

**Output**

![Image of soal1](https://github.com/agung56/SoalShiftSISOP20_modul1_T05/blob/master/img/soal1.png)
## Soal2
### Deskripsi Soal
**A**. Membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 kaeakter yang terdapat huruf besar, huruf kecil, angka.

**B**. Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang diinputkan dan **HANYA berupa alphabet**.

**C**. Kemudian supaya **file.txt** tersebut tidak mudah diketahui maka nama filenya akan dienkripsi dengan menggunakan konversi huruf (*string manipulation*) yang disesuaikan dengan jam (0-23) dibuatnya file tersebut dengan program terpisah

**D**. Membuat script untuk mendekripsi file yang telah di enkripsi

### Pembahasan

#### Soal 2(A dan B)
Code : https://github.com/agung56/SoalShiftSISOP20_modul1_T05/blob/master/soal2/soal2.sh

* Script untuk 2 A dan B
```
#!/bin/bash
password=`cat /dev/urandom | tr -d -c 'A-Za-z0-9' | fold -w 28 | head -n 1
filename=`echo $1 | tr -d -c 'A-Za-z'`

echo $password > $filename.txt
```
**Penjelasan Script**

`Password=cat /dev/urandom`

Membuat variabel *password* dan didalamnya menggunakan dev/urandom yang dimana dev/urandom ini merupakan sejenis library bawaan dari linux untuk membuat karakter secara acak (semua karakter baik angka, simbol, huruf, dll).

`| tr -d -c 'A-Za-z0-9'`

Selanjutnya dari hasil tersebut maka akan dilakukan *translate* dengan *command* **tr** yang dimana *translate* akan membuat suatu *infinite looping* menggunakan semua karakter dengan urandom sebelumnya sehingga perlu dilakukan *command* selanjutnya untuk memenuhi keperluan untuk isi *password*, *command* **-d** dan **-c** adalah *command* untuk *delete* dan *complement* atau **"hapus kecuali"**, sehingga semua karakter yang di*translate* tadi akan dihapus kecuali **'A-Za-z0-9'** yaitu permintaan dari soal

`| fold -w 28 | head -n 1`

Lalu dari *translate* tersebut dilakukan *command* **fold** untuk mengambil karakter dan dengan *command* **-w 28** yang artinya diambil karakter selebar **width** 28  karakter dan diambil hanya bagian **head atau paling atas** saja karena jika tidak diambil maka tetap yang ditampilkan adalah *infinite loop* tersebut dengan 28 karakter kesamping dan tidak ada batasan bawahnya maka dari itu dilakukan pengambilan head.

`filename=echo $1 | tr -d -c 'A-Za-z'`

Yang selanjutnya adalah dengan membuat variabel filename untuk nama file dengan cara **translate** yang sama dengan proses sebelumnya akan tetapi yang membedakan adalah yang dilakukan **hapus kecuali** hanyalah huruf kecil dan kapital (sesuai soal).

`echo $password > $filename.txt`

Lalu yang terakhir adalah memasukkan variabel **password** tadi ke dalam suatu file dengan nama sesuai dengan variabel **filename** tadi dan dengan ekstensi **.txt**

#### Soal 2 C
Code : https://github.com/agung56/SoalShiftSISOP20_modul1_T05/blob/master/soal2/soal_2enkripsi.sh
* Script untuk 2 C
```
#!/bin/bash

for tajuk in $@
do
time=`date +%H -r $tajuk`
tajuklama=`basename $tajuk .txt`

tajukbaru=`echo $tajuklama | caesar $time`
mv $tajuk $tajukbaru.txt
done
```
**Penjelasan Script**

`for tajuk in $@` Semua input yang dimasukkan pada program tersebut akan dijadikan sebagai **$@** dan kemudian dimasukkan kedalam variabel dengan nama **tajuk**.

`do

time=date +%H -r $tajuk`

Langkah selanjutnya adalah mencari atau mendapatkan jumlah jam (0-23) ketika file tersebut dibuat dimana pada soal yang tertera untuk melakukan enkripsi file tersebut dengan menggunakan algoritma caesar cipher yang menggunakan jumlah jam sebagai kunci(*key*) untuk menggeser huruf per huruf pada file tersebut. **date +%H** merupakan *command* yang digunakan untuk mendapatkan data berupa waktu file tersebut dibuat, dan **-r** merupakan *command* yang digunakan untuk membaca file yang akan dicari waktu file tersebut dibuat.

`tajuklama=basename $tajuk .txt`

Karena file yang dienkripsi hanya huruf atau alfabet saja, oleh karena itu digunakanlah *command* **basename** untuk menghapus ekstensi file yaitu .txt.

`tajukbaru=echo $tajuklama | caesar $time`

Setelah ekstensi file dihilangkan, kemudian melakukan proses enkripsi file tanpa ekstensi dengan jumlah jam yang telah didapat dengan metode caesar. Untuk **caesar** sendiri merupakan library yang tersedia di linux untuk mengenkripsi suatu file dengan metode caesar cipher, tetapi untuk menggunakan *command* tersebut terlebih dahulu harus mengunduhnya terlebih dahulu karena *command* **caesar** tersebut tidak tersedia secara *default* pada linux.

`mv $tajuk $tajukbaru.txt`
Setelah mendapatkan nama file baru setelah diekstensi kemudian langkah yang terakhir adalah mengganti nama file yang sebelumya dengan nama baru setelah dienkripsi dengan menambahkan ekstensi .txt kembali karena ekstensi sebelumnya telah dihapus sebelum file dienkripsi.


#### Soal 2 D
Code : https://github.com/agung56/SoalShiftSISOP20_modul1_T05/blob/master/soal2/soal_2dekripsi.sh

* Script untuk 2 D
```
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
**Penjelasan Script**

`for tajuk in $@` Semua input yang dimasukkan pada program tersebut akan dijadikan sebagai **$@** dan kemudian dimasukkan kedalam variabel dengan nama **tajuk**.

`do

time=date +%H -r $tajuk`

Langkah selanjutnya adalah mencari atau mendapatkan jumlah jam (0-23) ketika file tersebut dibuat dimana pada soal yang tertera untuk melakukan dekripsi file tersebut dengan menggunakan algoritma caesar cipher yang menggunakan jumlah jam sebagai kunci(*key*) untuk menggeser huruf per huruf pada file tersebut. **date +%H** merupakan *command* yang digunakan untuk mendapatkan data berupa waktu file tersebut dibuat, dan **-r** merupakan *command* yang digunakan untuk membaca file yang akan dicari waktu file tersebut dibuat.

`tajuklama=basename $tajuk .txt`

Karena file yang didekripsi hanya huruf atau alfabet saja, oleh karena itu digunakanlah *command* **basename** untuk menghapus ekstensi file yaitu .txt.

`jambaru=expr 26 - $jam`

Setelah menghilangkan ekstensi, selanjutnya dilakukan penghitungan ulang dengan cara 26 (jumlah alfabet) dikurangi dengan jam file dibuat. Kenapa pengurangan yang dilakukan **26 - $jam** bukan **$jam - 26**, karena apabila **$jam - 26** akan menghasilkan nilai minus dimana huruf akan digeser kekiri, apabila jumlah huruf yang digeser pada saat enkripsi ataupun pada saat dekripsi tidak seimbang maka huruf tidak akan kembali keposisi semula sebelum file dienkripsi.

`tajukbaru=echo $tajuklama | caesar $time`

Setelah ekstensi file dihilangkan dan variabel **$jambaru** sebagai kunci (*key*) baru untuk dekripsi file didapat, kemudian melakukan proses dekripsi file tanpa ekstensi dengan jumlah jam yang telah didapat dengan metode caesar. Untuk **caesar** sendiri merupakan library yang tersedia di linux untuk mengenkripsi suatu file dengan metode caesar cipher, tetapi untuk menggunakan *command* tersebut terlebih dahulu harus mengunduhnya terlebih dahulu karena *command* **caesar** tersebut tidak tersedia secara *default* pada linux.

`mv $tajuk $tajukbaru.txt`
Setelah mendapatkan nama file baru setelah diekstensi kemudian langkah yang terakhir adalah mengganti nama file yang sebelumya dengan nama baru setelah didekripsi dengan menambahkan ekstensi .txt kembali karena ekstensi sebelumnya telah dihapus sebelum file didekripsi dan nama file kembali seperti semula sebelum dienkripsi.


## Soal 3
### Deskripsi Soal
**A**. Membuat script untuk mendownload 28 gambar dari "https://loremflickr.com/320/240/cat" menggunakan command **wget** dan menyimpan file dengan nama "pdkt_kusuma_NO" serta menyimpan **log message wget** kedalam sebuah file "wget.log"

**B**. Membuat crontab download file **setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari sabtu**

**C**. Membuat script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate dengan format filename "duplicate_nomor". Setelah itu lakukan pemindahan semua gambar yang tersisa ke dalam folder ./kenangan dengan format filename "kenangan_nomor". Setelah tidak ada gambar di *current directory*, maka lakukan backup seluruh log menjadi ekstensi ".log.bak".

### Pembahasan

#### Soal 3 A
Code : https://github.com/agung56/SoalShiftSISOP20_modul1_T05/blob/master/soal3/soal3.sh
* Script untuk 3 A
```
#!/bin/bash

#untuk mengambil 28 gambar berbeda dan dengan nama akhir berbeda
for gambar in {1..28}
do
wget "https://loremflickr.com/320/240/cat" -a wget.log -O "pdkt_kusuma_$gambar"
done
```
**Penjelasan Script**

`for gambar in {1..28}`Digunakan untuk *melooping* jumlah gambar yang diunduh hingga berjumlah 28 dan dimasukkan ke variabel **gambar**.
`do
wget "https://loremflickr.com/320/240/cat" -a wget.log -O "pdkt_kusuma_$gambar"
done`

Selama melakukan looping dari 1 hingga 28, dilakukan proses pengunduhan gambar pada situs **https://loremflickr.com/320/240/cat**, *command* **-a** digunakan untuk menampilkan isi log pada saat mengunduh gambar dan kemudian disimpan pada file **wget.log**. Sedangkan *command* **-O** digunakan untuk memberi nama pada tiap gambar yang telah diunduh dengan nama **"pdkt_kusuma_$gambar"** dimana **$gambar** merupakan angka atau urutan pada saat proses pengunduhan tadi. Contoh gambar pertama yang diunduh diberi nama "pdkt_kusuma_1" dan seterusnya hingga gambar yang diunduh berjumlah 28.

#### Soal 3 B
Code : https://github.com/agung56/SoalShiftSISOP20_modul1_T05/blob/master/soal3/crontab.txt
* Script untuk 3 B

`5 6-23/8 * * 0-5 /bin/bash /home/lab/Downloads/modul1/soal3/soal3.sh`

**Penjelasan Script**

Maksud dari *script* diatas adalah menjalankan program soal3.sh setiap 8 jam sekali pada menit ke-5 yang dimulai pada pukul 6.05 hingga pukul 23.00 selama 6 hari mulai hari minggu hingga hari jumat. Untuk angka **5** menandakan menit, angka **6-23/8** menandakan tiap 8 jam dari pukul 6 hingga 23, tanda **bintang** selanjutnya program berjalan setiap hari mulai tanggal 1 dan seterusnya, untuk tanda **bintang** yang keempat menandakan program dilakukan tiap bulan, dan angka **0-5** menandakan program dilakukan pada hari minggu hingga hari jumat. Perintah **/bin/bash** digunakan untuk menjalankan file bertipe .sh. Dan yang terakhir **/home/lab/Downloads/modul1/soal3/soal3.sh** merupakan lokasi program yang akan dilakukan secara otomatis sesuai jadwal yang telah ditentukan.

#### Soal 3 C
Code : https://github.com/agung56/SoalShiftSISOP20_modul1_T05/blob/master/soal3/soal3c.sh
* Script untuk 3 C
```
#!/bin/bash

mkdir kenangan
mkdir duplicate

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
**Penjelasan Script**

Sebelum memindahkan file gambar ke folder kenangan ataupun duplikat, folder harus telah dibuat terlebih dahulu dengan menggunakan *command* `mkdir kenangan 
mkdir duplicate`.

`coba=ls | grep "pdkt_kusuma_" | cut -d "_" -f 3 | sort -n | tail -1` 

Setelah folder dibuat, gambar diurutkan mulai dari nomor 1 hingga nomor 28. *Command* **ls** digunakan untuk menampilkan semua *list* file yang ada pada direktori. Karena yang dibutuhkan hanya file berupa gambar, maka digunakan *command* **grep** untuk mengambil file dengan nama **pdkt_kusuma_**. *Command* `cut -d "_" -f 3` digunakan untuk mengambil hanya variabel ketiga dari nama file dengan **-d "_"** sebagai pemisah (separator) dan **-f 3** untuk mengambil variabel ketiga dimana variabel tersebut berisi angka atau nomor urut file tersebut. *Command* `arr=""` tersebut masih kosong dan nantinya akan diisi oleh lokasi dari gambar yang akan dijelaskan pada baris berikutnya. Setelah itu dilakukan *looping* untuk membaca atau memeriksa gambar satu-persatu.

`lokasi=cat wget.log | grep "Location" | head -$i | tail -1 | cut -d " "  -f 2`

Selama proses *loop* berlangsung yang pertama dilakukan adalah mencari lokasi file gambar tersebut yang dapat diperoleh dari file wget.log. *Command* `grep "Location"` untuk mengambil lokasinya saja, `head -$i | tail -1 | cut -d " "  -f 2` kemudian file tersebut disusun dengan nilai **$i** sesuai dengan proses *loop* diatasnya yang kemudian diambil lokasi terbawah. Misal ada total 28 file, ketika **$i=5** maka akan diambil 5 file teratas dari 28 file tersebut dan kemudian diambil 1 yang terbawah berdasarkan 5 file tadi dengan menggunakan *command* **tail -1**. Setelah itu diambil hanya variabel kedua dari lokasi tadi karena nilai pada variabel tersebut bersifat unik yang membedakan antara file satu dengan file yang lain.

`duplikat=echo -e $arr | awk -v loc=$lokasi 'BEGIN{duplikatlagi=0}{if(loc==$0) duplikatlagi=1} END {printf "%d", duplikatlagi}'`

Setelah mendapatkan lokasi yang bersifat unik tadi, langkah yang dilakukan berikutnya adalah memeriksa apakah ada file lain yang memiliki lokasi yang sama dengan file yang lokasinya telah didapatkan tadi. Yang pertama dilakukan adalah menampilkan variabel **arr** yang masih kosong tadi diisi dengan nilai lokasi file Kemudian lokasi yang telah didapat tadi dimasukkan ke `awk -v loc=$lokasi 'BEGIN{duplikatlagi=0}{if(loc==$0) duplikatlagi=1} END {printf "%d", duplikatlagi}'` dimana **loc** adalah lokasi file yang telah didapat tadi dan kemudian diperiksa jika nilai loc tadi sama dengan nilai lokasi pada **arr** maka gambar tersebut duplikat atau ada lebih dari satu gambar yang serupa. 
```
if [[ $duplikat == 0 ]]
then

arr="$arr$lokasi\n"
mv pdkt_kusuma_$i kenangan/kenangan_$i
else
mv pdkt_kusuma_$i duplicate/duplicate_$i
fi
done
```
Setelah mendapatkan nilai dari **$duplikat** (0 atau 1), nilai tersebut dicek jika **$duplikat==0** maka file tersebut bukan duplikat dan selanjutnya file tersebut dipindah kedalam folder kenangan dan sebaliknya jika **$duplikat!=0** maka file tersebut dipindah kedalam folder duplikat. *Command* `arr="$arr$lokasi\n"` digunakan untuk memasukkan nilai lokasi tadi kedalam bersama varibel arr yang masih kosong kedalam variabel arr agar variabel **$arr** pada variabel **$duplikat** dapat diisi lokasi file yang lain.

`cat wget.log >> wget.log.bak
rm wget.log` 

Setelah semua file dipindah kedalam folder kenangan atau folder duplikat, langkah yang terakhir adalah membuat file dengan ekstensi .log.bak sesuai dengan petunjuk yang diberikan, yaitu dengan menyalin isi file **wget.log** kedalam **wget.log.bak** dengan menggunakan *command* **cat** dan terakhir menghapus file **wget.log** karena sudah tidak digunakan lagi.

### Kendala yang dihadapi selama proses pengerjaan soal shift
* Tingkat kesulitan dari soal yang sangat sulit bagi pemula seperti kami
* Terdapat beberapa materi yang tidak diberikan pada sesi lab yang kemudian muncul pada soal shift
* File crontab yang tidak berjalan sesuai dengan keinginan
* Soal 3 C yang menurut kami sangat sulit karena sebelumnya tidak pernah diajarkan pada sesi lab maupun pada saat asistensi,     kesulitan saat membuat script untuk mengidentifikasi apakah gambar tersebut merupakan duplikat atau bukan 
* Sedikit Kebingungan saat hendak membuat program membuat password secara acak
