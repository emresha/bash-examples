#!/bin/bash

#-----------настройки------------
output_name="app"
c_file=$(find ./*.c)
#--------------------------------
echo -e "\e[93m[INFO]Debug build with memory sanitizer\e[0m"

if [ -z "$c_file" ] || [ "$c_file" = "" ]; then
    echo -e "\e[31m.c file not found\e[0m"
    exit 1
fi

if clang -std=c99 -Wall -Werror -Wpedantic -Wfloat-equal -Wfloat-conversion -Wextra -g -fsanitize=memory -fPIE -pie -fno-omit-frame-pointer -o "$output_name".exe "$c_file" -lm; then
    echo -e "\e[32m[DEBUG]Executable compilation success\e[0m"
else
    echo -e "\e[31m[DEBUG]Executable compilation error\e[0m"
    exit 2
fi

if clang -fsanitize=memory -fPIE -fno-omit-frame-pointer -c "$c_file" -o "$output_name".o -g; then
    echo -e "\e[32m[DEBUG]Object file compilation success\e[0m"
else
    echo -e "\e[31m[DEBUG]Object file compilation error\e[0m"
    exit 2
fi

exit 0

