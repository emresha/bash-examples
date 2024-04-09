#!/bin/bash

filename=$(find ./*.c)

if gcc -std=c99 -Wall -Werror -Wpedantic -Wfloat-equal -Wfloat-conversion -O0 --coverage -Wextra -o app.exe "$filename" -lm; then
    echo -e "\e[32mCompilation success\e[0m"
else
    echo -e "\e[31  mCompilation error\e[0m"
    exit 1
fi
