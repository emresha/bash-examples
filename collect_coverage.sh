#!/bin/bash

# настройки
filename=$(find ./*.c)

if [ "$filename" == "" ] || [ -z "$filename" ]; then
    echo ".c file not found"
fi

cd func_tests/scripts/ || exit 1
./func_tests.sh > /dev/null

cd ../.. || exit 1
gcov -o ./*.gcda "$filename"