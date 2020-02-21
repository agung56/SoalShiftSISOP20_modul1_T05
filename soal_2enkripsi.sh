#!/bin/bash

for tajuk in $@
do
time=`date +%H -r $tajuk`
tajuklama=`basename $tajuk .txt`

tajukbaru=`echo $tajuklama | caesar $time`
mv $tajuk $tajukbaru.txt
done
