#!/bin/bash

name="apache2"
pid_proc=`pgrep -U root $name`

if [ $((pid_proc)) -gt 0 ]
then
	`kill -15 $pid_proc`
	echo "Process $name $pid_proc stopped"
fi

echo "wait 10 seconds"
`sleep 10`


pid_proc=`pgrep -U root $name`
if [ $((pid_proc)) -gt 0 ]
then
	`kill -9 $pid_proc`
	echo "Process $name $pid_proc stopped"
fi
