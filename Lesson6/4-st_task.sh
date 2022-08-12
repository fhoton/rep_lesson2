#!/bin/bash

`lsof -u $USER | tr -s " " | cut -d ' ' -f 2,4,9 > PID_proc.txt`


