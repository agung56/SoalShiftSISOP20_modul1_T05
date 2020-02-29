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
