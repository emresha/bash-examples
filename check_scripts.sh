#!/bin/bash

directory="./"

found=0
success=0
for script in "$directory"*.sh; do
    ((found++))
    echo -e "[INFO]Checking $script"
    if shellcheck "$script"; then
        echo -e "\e[32m[INFO]Success!\e[0m"
        ((success++))
    fi
done

for script in "$directory"func_tests/scripts/*.sh; do
    ((found++))
    echo -e "[INFO]Checking $script"
    if shellcheck "$script"; then
        echo -e "\e[32m[INFO]Success!\e[0m"
        ((success++))
    fi
done

echo "Shellcheck found problems in $((found - success)) scripts out of $found"