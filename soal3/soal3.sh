#!/bin/bash

#untuk mengambil 28 gambar berbeda dan dengan nama akhir berbeda
for gambar in {1..28}
do
wget "https://loremflickr.com/320/240/cat" -a wget.log -O "pdkt_kusuma_$gambar"
done

