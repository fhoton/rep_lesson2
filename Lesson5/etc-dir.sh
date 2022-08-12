#!/bin/bash

echo "---------`date +%F`---`date +%T`--------------" >> etc_dir.txt

for file in `find /etc/*` # script run from sudo
do
	if [ -d $file ]
	then
		echo "$file" >> etc_dir.txt
	fi


done
