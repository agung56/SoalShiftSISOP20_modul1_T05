#!/bin/bash

for tajuk in $@
do
jam=`date +%H -r $tajuk`
tajuklama=`basename $tajuk .txt`
jambaru=`expr 26 - $jam`
tajukbaru=`echo $tajuklama | caesar $jambaru`
mv $tajuk $tajukbaru.txt
done
