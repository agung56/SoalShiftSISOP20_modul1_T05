#!/bin/bash

password=`cat /dev/urandom | tr -d -c 'A-Za-z0-9' | fold -w 28 | head -n 1`
filename=`echo $1 | tr -d -c 'A-Za-z'`

echo $password > $filename.txt
