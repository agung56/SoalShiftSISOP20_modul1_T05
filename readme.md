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
#### Soal 2 D
Code : https://github.com/agung56/SoalShiftSISOP20_modul1_T05/blob/master/soal2/soal_2dekripsi.sh

* Script untuk 2 D

## Soal 3
### Deskripsi Soal
**A**. Membuat script untuk mendownload 28 gambar dari "https://loremflickr.com/320/240/cat" menggunakan command **wget** dan menyimpan file dengan nama "pdkt_kusuma_NO" serta menyimpan **log message wget** kedalam sebuah file "wget.log"

**B**. Membuat crontab download file **setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari sabtu**

**C**. Membuat script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate dengan format filename "duplicate_nomor". Setelah itu lakukan pemindahan semua gambar yang tersisa ke dalam folder ./kenangan dengan format filename "kenangan_nomor". Setelah tidak ada gambar di *current directory*, maka lakukan backup seluruh log menjadi ekstensi ".log.bak".

### Pembahasan

#### Soal 3 A
Code : https://github.com/agung56/SoalShiftSISOP20_modul1_T05/blob/master/soal3/soal3.sh
* Script untuk 3 A
#### Soal 3 B
Code : https://github.com/agung56/SoalShiftSISOP20_modul1_T05/blob/master/soal3/crontab.txt
* Script untuk 3 B

#### Soal 3 C
Code : https://github.com/agung56/SoalShiftSISOP20_modul1_T05/blob/master/soal3/soal3c.sh
* Script untuk 3 C
