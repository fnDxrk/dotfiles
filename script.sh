#!/usr/bin/env bash
set -euo pipefail

if [[ $EUID -eq 0 ]]; then
    echo "Run without sudo/root!" >&2
    exit 1
fi

cd "$(dirname "$0")"

user=$(id -un)

## Autologin
getty_dir=/etc/systemd/system/getty@tty1.service.d

sed "s/<USER>/$user/" system/autologin.conf |
sudo install -Dm644 /dev/stdin "$getty_dir/autologin.conf"

sudo systemctl daemon-reload

## Other
