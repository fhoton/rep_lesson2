#!/bin/bash

file=usr_executables.txt

wc -l $file | cut -d ' ' -f1

head -10 $file | cut -d '/' -f4 > cmd_names


#cat $file | for ((i=1; i<=10; i++))
#do
# 	echo "Line : $line"
#	echo "$i"


#done



