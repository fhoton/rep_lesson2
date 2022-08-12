#!/bin/bash

echo "------`date +%F`---`date +%T`----------------------" >> executable.txt


#for item in /usr/bin/*
for item in `find /usr/bin/`
do
	
	if [ -f $item ]
	then
		if [ -x $item ]
		then
			echo $item >> executable.txt
		fi
	fi

done

