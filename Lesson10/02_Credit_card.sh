#!/bin/bash

echo "1234-1234-1234-1234 02/34" | awk '/([0-9]{4}-){3}[0-9]{4} [0-1][1-9]\/[0-9][0-9]/'