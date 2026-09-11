# Infrastructure as Code: High-Availability Home Server 🛠️

Декларативное описание инфраструктуры домашнего микро-ЦОД на базе гипервизора Proxmox VE. 
Архитектура построена с учетом лучших практик: изоляция сервисов, безопасность сети и многоуровневое хранение данных.

## 🏗️ Архитектура

* **Оркестрация:** Docker Engine внутри привилегированных LXC-контейнеров (Debian 12).
* **Сеть:** OpenWrt в качестве Core-маршрутизатора с политиками Policy-Based Routing (PBR).
* **Хранение данных (Storage):**
  * **Hot Storage:** NVMe кэш для баз данных и Docker volumes.
  * **Cold Storage:** Массив из нескольких HDD, объединенных через `MergerFS` с политикой записи по свободному месту (min free space).
* **Безопасность (Reverse Proxy):** `Caddy` веб-сервер с автоматической выпиской Let's Encrypt сертификатов и строгим контролем доступа извне.

## 🛡️ Безопасность и Изоляция (Zero Trust)
* LXC-контейнеры изолированы правилами Proxmox Firewall (политика `DROP` по умолчанию).
* Гостевые/внешние VPN-шлюзы помещены в DMZ: им разрешен доступ только в WAN, доступ к Management-сети и локальным сервисам аппаратно блокируется (`nftables`).

## 🚀 Быстрый старт
```bash
git clone https://github.com/nlkolay/homelab-infrastructure.git
cd homelab-infrastructure
docker compose up -d
