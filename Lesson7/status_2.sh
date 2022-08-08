#!/bin/bash

name="apache2"
pid_proc=`pgrep -U root $name`

if [ $((pid_proc)) -gt 0 ]
then
#	`kill -18 $pid_proc`
	`kill -15 $pid_proc`
	for i in {1..30}
	do
		`sleep 1`
		echo "process $name $pid_proc suspended"

	done
else
	echo "process $name not search"
fi

