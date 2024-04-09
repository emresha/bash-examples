#!/bin/bash

echo -e "\e[93m[INFO]Deleting all .exe, .o and unnecessary .txt files ...\e"

if rm ./*.exe --verbose; then
    echo ""
else
    echo -e "\e[93m[INFO]No .exe files found\e"
fi

if rm ./*.o --verbose; then
    echo ""
else
    echo -e "\e[93m[INFO]No .o files found"
fi

if rm ./output.txt --verbose; then
    echo ""
else
    echo -e "\e[93m[INFO]No unnecessary .txt files found in $(pwd)"
fi

if rm ./func_tests/scripts/output.txt --verbose; then
    echo ""
else
    echo -e "\e[93m[INFO]No unnecessary .txt files found\e[0m"
fi

rm ./*.gcov ./*.gcda ./*.gcno 2> /dev/null

echo -e "\e[32m[INFO]Successfully deleted\e[0m"