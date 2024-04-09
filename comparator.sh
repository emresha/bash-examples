#!/bin/bash

export LC_ALL=C.UTF-8 # !!!

if [ "$#" -ne 2 ]; then
    echo -e "\e[31m[ERROR]Usage: $0 file1.txt file2.txt\e[0m"
    exit 1
fi

echo -e "[INFO]Comparing $1 and $2..."

file1="$1"
file2="$2"

if [ ! -f "$file1" ]; then
    echo -e "\e[31m[ERROR]$file1 does not exist.\e[0m"
    exit 1
fi

if [ ! -f "$file2" ]; then
    echo -e "\e[31m[ERROR]$file2 does not exist.\e[0m"
    exit 1
fi

output=$(diff -u <(grep -oP "(?<!\S)-?[0-9]+\.?[0-9]*(?!\S)" "$file1") <(grep -oP "(?<!\S)-?[0-9]+\.?[0-9]*(?!\S)" "$file2"))

if [ -z "$output" ]; then
    echo -e "\e[32m[INFO] $1 and $2 are equal\e[0m"
    exit 0
else
    echo -e "\e[31m[INFO] $1 and $2 are different\e[0m"
    exit 2
fi
