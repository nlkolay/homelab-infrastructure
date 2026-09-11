#!/bin/bash
set -euo pipefail

echo "Создание точек монтирования физических накопителей..."
mkdir -p /mnt/disk_main
mkdir -p /mnt/disk_aux1
mkdir -p /mnt/disk_aux2
mkdir -p /mnt/disk_trash
mkdir -p /mnt/media_pool

echo "Проверка доступности утилиты mergerfs..."
if ! command -v mergerfs &> /dev/null; then
    echo "Утилита mergerfs не найдена. Установка пакетов..."
    apt-get update && apt-get install -y mergerfs fuse
fi

echo "Монтирование файловых систем согласно fstab..."
mount -a

echo "Установка прав доступа на пулы хранения..."
chmod -R 777 /mnt/disk_* /mnt/media_pool

echo "Готово. Структура смонтирована:"
df -h | grep -E "disk_|media_pool"
