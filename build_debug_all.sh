#!/bin/bash

# скрипт для запуска всех debug скриптов c санитайзерами не найдено

for script in *debug_*san*; do
    echo "[INFO]Running $script"
    ./"$script"
    ./func_tests/scripts/func_tests.sh
    rm ./app.exe
done

./clean.sh
exit 0