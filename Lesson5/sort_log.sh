#!/bin/bash


echo "-----`date +%F`---`date +%T`------------------" >> sort_var_log_files.txt


for file in `ls -lS /var/log/*`
do

	if [ -f $file ]
	then
		echo "$file"
		echo "$file" >> sort_var_log_files.txt
	fi
	
done

