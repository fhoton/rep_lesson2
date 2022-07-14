#!/bin/bash

path1=/usr/bin
path2=/usr/sbin



for file in `find $path1 $path2 -type f `

do
	if [ -x $file ]
	then
		echo "$file" >> executables
	fi
	
done

sleep 100
