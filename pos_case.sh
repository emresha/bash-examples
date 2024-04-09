#!/bin/bash

# получаем путь к скрипту
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ "$#" -ne 2 ]; then
    echo -e "\e[31m[ERROR]Usage: $0 file1 file2\e[0m"
    exit 1
fi

if [ ! -f "$1" ] || [ ! -f "$2" ]; then
    echo -e "\e[31m[ERROR]Non-existent file(s)\e[0m"
    exit 1
fi

file_in=$1
file_out=$2

"$SCRIPT_DIR"/../../app.exe < "$file_in" > output.txt
return_code=$?

if [ "$return_code" -ne 0 ]; then
    exit 1
else
    "$SCRIPT_DIR"/comparator.sh output.txt "$file_out" > /dev/null
    rc=$?
    if [ $rc -eq 0 ]; then
        exit 0
    else
        exit 2
    fi
fi