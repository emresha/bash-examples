#!/bin/bash

# получаем путь к скрипту
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ "$#" -ne 1 ]; then
    echo -e "\e[31m[ERROR]Usage: $0 file.txt\e[0m"
    exit 2
fi

file_in="$1"

if [ ! -f "$file_in" ]; then
    echo -e "\e[31m[ERROR]File '$file_in' does not exist\e[0m"
    exit 2
fi

"$SCRIPT_DIR"/../../app.exe < "$file_in" > /dev/null
exit_code=$?

if [ "$exit_code" -ne 0 ]; then
    # echo -e "\e[32m[INFO]Test success\e[0m" молчаливый режим
    exit 0
fi

# echo -e "\e[31m[INFO]Application returned zero\e[0m" молчаливый режим
exit 1