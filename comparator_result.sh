#!/bin/bash

# данный компаратор проверяет всё, что после подстроки "Result: "

export LC_ALL=C.UTF-8

if [ $# -ne 2 ]; then
    echo -e "\e[31m[ERROR]Usage $0 file1 file2\e[0m"
    exit 1
fi

# вывод grep будет по типу "int:Result: ", где int - индекс первого вхождения
# т.к. нам нужен только индекс вхождения, используя cut его и получаем
res_index_1=$(grep -b -o 'Result: ' "$1" | cut -d ':' -f 1)
res_index_2=$(grep -b -o 'Result: ' "$2" | cut -d ':' -f 1)

if [ -z "$res_index_1" ] || [ -z "$res_index_2" ]; then
    echo -e "\e[31m[ERROR]'Result: ' not found in file(s)\e[0m"
    exit 1
fi

# 9 - это длина подстроки "Result: " + 1
to_compare_1=$(tail -c +$((res_index_1 + 9)) "$1")
to_compare_2=$(tail -c +$((res_index_2 + 9)) "$2")

if [ "$to_compare_1" = "$to_compare_2" ]; then
    echo -e "\e[32m[INFO] $1 and $2 are equal\e[0m"
else
    echo -e "\e[31m[INFO] $1 and $2 are different\e[0m"
fi

exit 0