#!/bin/bash

error_count=0
count=1
all=0
verbose=0

# получаем путь к скрипту
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ $# -eq 1 ] || [ "$1" = "-v" ]; then
    verbose=1
fi

for positive_test in "$SCRIPT_DIR"/../data/pos_*_in.txt; do
    ((all++))
    file_prefix="${positive_test%%_in*}"
    "$SCRIPT_DIR"/pos_case.sh "$file_prefix"_in.txt "$file_prefix"_out.txt
    rc=$?

    if [ $verbose -eq 1 ]; then
        echo "pos test $count"
        echo "in >> '$file_prefix'_in.txt"
        cat "$file_prefix"_in.txt
        echo ""
        echo "out << '$file_prefix'_out.txt"
        cat "$file_prefix"_out.txt
        echo ""
    fi

    if [ $rc -eq 0 ]; then
        echo -e "\e[32m[INFO]Positive test $count pass\e[0m"
    else
        echo -e "\e[31m[INFO]Positive test $count fail\e[0m"
        ((error_count++))
    fi
    ((count++))
done

count=1


for negative_test in "$SCRIPT_DIR"/../data/neg_*_in.txt; do
    if [ ! -e "$negative_test" ]; then
        echo "[INFO]No negative files found."
        break
    fi
    ((all++))
    file_prefix="${negative_test%%_in*}"
    "$SCRIPT_DIR"/neg_case.sh "$file_prefix"_in.txt 
    rc=$?

    if [ $verbose -eq 1 ]; then
        echo "neg test $count"
        echo "in >> '$file_prefix'_in.txt"
        cat "$file_prefix"_in.txt
        echo ""
        echo "expect non-zero return code"
        echo ""
    fi

    if [ $rc -eq 0 ]; then
        echo -e "\e[32m[INFO]Negative test $count pass\e[0m"
    else
        echo -e "\e[31m[INFO]Negative test $count fail\e[0m"
        ((error_count++))
    fi
    ((count++))
done


echo "[INFO]$((all - error_count)) tests passed out of $all"

if [ "$error_count" -eq 0 ]; then
    echo -e "\e[32m[INFO]Successfully passed all tests!\e[0m"
    exit 0
else
    echo -e "\e[31m[INFO]Failures encountered. Application did not pass the functional testing.\e[0m"
    exit 1
fi