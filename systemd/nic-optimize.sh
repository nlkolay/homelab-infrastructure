#!/bin/bash
set -euo pipefail

# Список физических сетевых интерфейсов Realtek RTL8111H
TARGET_INTERFACES="nic0 nic1"

for IFACE in $TARGET_INTERFACES; do
    if ip link show "$IFACE" &> /dev/null; then
        echo "Применение оптимизации к интерфейсу $IFACE..."
        
        # 1. Отключение энергосбережения IEEE 802.3az (устраняет деградацию в 100 Мбит/с)
        ethtool --set-eee "$IFACE" eee off || true
        
        # 2. Фиксация дуплекса и гигабитного режима
        ethtool -s "$IFACE" speed 1000 duplex full autoneg on || true
        
        # 3. Отключение прерываний Wake-on-LAN для исключения коллизий шины
        ethtool -s "$IFACE" wol d || true
    else
        echo "Интерфейс $IFACE не обнаружен в системе, пропуск."
    fi
done
