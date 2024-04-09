#!/bin/bash

# настройки
filename=$(find ./*.c)
output_name="app"

if [ "$filename" == "" ] || [ -z "$filename" ]; then
    echo ".c file not found"
fi

if gcc -std=c99 -Wall -Werror -Wpedantic -Wfloat-equal -Wfloat-conversion -Wextra -o app.exe "$filename" -lm; then
    echo -e "\e[32mCompilation success\e[0m"
else
    echo -e "\e[31mCompilation error\e[0m"
    exit 1
fi

if gcc -c "$filename" -o "$output_name".o; then
    echo -e "\e[32mObject file compilation success\e[0m"
else
    echo -e "\e[31mObject file compilation error\e[0m"
fi