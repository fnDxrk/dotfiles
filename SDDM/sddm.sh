#!/bin/bash
set -e

# Autologin
USERNAME=$(whoami)
sed -i "s|^User=.*|User=$USERNAME|" autologin.conf
sudo cp autologin.conf /etc/sddm.conf.d/autologin.conf

# Primary monitor
sudo cp Xsetup /usr/share/sddm/scripts/Xsetup
