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




