## Установка
### Настройка интернета

```
ping 8.8.8.8
```

```
iwctl
station wlan0 connect SSID
```
### Часового пояс

```
date
timedatectl set-timezone Asia/Novosibirsk
```
### Разбиение диска

```
lsblk
cfdisk -z /dev/sda
```

|  Раздел   | Точка монтирования |      Размер      |
| :-------: | :----------------: | :--------------: |
| /dev/sdX1 |        EFI         |      600 МБ      |
| /dev/sdX2 |         /          |      40 ГБ       |
| /dev/sdX3 |       /home        | Оставшееся место |
### Форматирование разделов

```
mkfs.fat -F 32 /dev/sdX1
mkfs.btrfs /dev/sdX2 -L "Arch"
mkfs.btrfs /dev/sdX3 -L "Home"
```
### Монтирование разделов

```
mount --mkdir /dev/sdX1 /mnt/boot
mount -o noatime,ssd,space_cache=v2,compress-force=zstd:3,discard=async /dev/sdX2 /mnt
mount --mkdir -o noatime,ssd,space_cache=v2,compress-force=zstd:3,discard=async /dev/sdX3 /mnt/home
```
### Установка базовых пакетов

```
pacstrap -K /mnt base base-devel linux linux-firmware git amd-ucode sudo nano networkmanager
```
### Fstab

```
genfstab -U /mnt >> /mnt/etc/fstab
```
### Chroot

```
arch-chroot /mnt
```
### Настройка времени

```
ln -sf /usr/share/zoneinfo/Asia/Novosibirsk /etc/localtime
hwclock --systohc
```
### Локализация

```
/etc/locale.gen
------------------------------------------------------------------------------
(Раскомментировать)
en_US.UTF-8 UTF-8
ru_RU.UTF-8 UTF-8
------------------------------------------------------------------------------
```

```
locale-gen
echo "LANG=ru_RU.UTF-8" >> /etc/locale.conf
echo -e "KEYMAP=ru \nFONT=cyr-sun16" >> /etc/vconsole.conf
```
### Настройка сети

```
echo "ИМЯ-ХОСТА" >> /etc/hostname
```

```
/etc/hosts
------------------------------------------------------------------------------
127.0.0.1	localhost
::1         localhost
127.0.1.1	ИМЯ-ХОСТА
------------------------------------------------------------------------------
```
### Добавление нового пользователя

```
useradd -G wheel,users -s /bin/bash -m NAME
```
### Пароль

```
Для пользователя NAME :
passwd NAME
: PASSWORD
```

```
Для root :
passwd
: PASSWORD
```
### Репозиторий multilib

```
/etc/pacman.conf
------------------------------------------------------------------------------
(Раскомментировать)
[multilib]
Include = /etc/pacman.d/mirrorlist
------------------------------------------------------------------------------
```
### Root-права пользователям

```
/etc/sudoers
------------------------------------------------------------------------------
(Раскомменировать)
%wheel      ALL=(ALL:ALL) ALL
------------------------------------------------------------------------------
```
### Загрузчик

```
bootctl install
bootctl update
```

```
/boot/loader/loader.conf
------------------------------------------------------------------------------
default arch.conf
timeout 
console-mode max
editor yes
------------------------------------------------------------------------------
```

```
/boot/loader/entries/arch.conf
------------------------------------------------------------------------------
title	ArchLinux
linux	/vmlinuz-linux
initrd	/amd-ucode.img
initrd	/initramfs-linux.img
options	root="LABEL=Arch" rw quiet splash loglevel=3 udev.log_level=3 zswap.enabled=0
------------------------------------------------------------------------------
```

```
/etc/mkinitcpio.conf
------------------------------------------------------------------------------
...
BINARIES=(setfont)
...
------------------------------------------------------------------------------
```
### Initramfs

```
mkinitcpio -P
```
### Systemd

```
systemctl enable NetworkManager.service
systemctl enable fstrim.timer
```
### Завершение

```
exit
reboot 
```

## Настройка системы
### Yay

```
git clone https://aur.archlinux.org/yay-bin
cd yay-bin
makepkg -si
cd && rm -rf yay-bin
```
### XDG user directories

```
yay -S xdg-user-dirs
LC_ALL=C xdg-user-dirs-update --force
```
### Reflector

```
yay -S reflector
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist_copy
sudo reflector -c Russia -l 10 --sort rate --save /etc/pacman.d/mirrorlist
systemctl enable --now reflector.timer
```
### Zram

```
yay -S zram-generator

sudo nano /etc/systemd/zram-generator.conf
------------------------------------------------------------------------------
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
swap-priority = 100
fs-type = swap
------------------------------------------------------------------------------

reboot
systemctl start systemd-zram-setup@zram0.service
```

### Polkit

```
yay -S polkit-gnome

~/.config/hypr/hyprland.conf
------------------------------------------------------------------------------
exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
------------------------------------------------------------------------------
```
### AMD

```
yay -S mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver vulkan-mesa-layers opencl-rusticl-mesa lib32-opencl-rusticl-mesa
```
### Nvidia

```
yay -S nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader nvidia-prime mesa-utils linux-headers dkms 
```

Включение режим ядра DRM :

```
/etc/modprobe.d/nvidia-kms.conf
------------------------------------------------------------------------------
options nvidia_drm modeset=1 fbdev=1
------------------------------------------------------------------------------
```

Для проверки работы видеокарты :

```
# Вывод информации о видеоустройствах
lspci -k | grep -A 2 -E "(VGA|3D)"

# Рендер
prime-run glxinfo | grep "OpenGL renderer"
 __GL_SYNC_TO_VBLANK=0 prime-run glxgears
```
### Zsh

```
yay -S zsh zsh-antidote

~/.zshenv
------------------------------------------------------------------------------export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export HISTFILE="$ZDOTDIR/.zhistory"    
export HISTSIZE=10000                  
export SAVEHIST=10000                 

export EDITOR="nvim"
export VISUAL="nvim"
------------------------------------------------------------------------------

$ZDOTDIR/.zsh_plugins.txt
------------------------------------------------------------------------------
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-completions
romkatv/powerlevel10k

```
### Bluetooth

```
yay -S blueberry
systemctl enable --now bluetooth.service
```
### Оптимизация CPU

```
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq && sudo ./auto-cpufreq-installer

/etc/auto-cpufreq.conf
------------------------------------------------------------------------------
[charger]
governor = perfomance
energy_performance_preference = performance
# scaling_min_freq = 800000
scaling_max_freq = 3800000
turbo = never

[battery]
governor = powersave
energy_performance_preference = balance_power
# scaling_min_freq = 800000
scaling_max_freq = 3800000
turbo = never

# battery charging threshold
#enable_thresholds = true
#start_threshold = 20
#stop_threshold = 80
------------------------------------------------------------------------------
```
### Батарея

```
# После установки пакетов нужно перезагрузиться
yay -S upower acpi acpi_call lenovo-legion-electric-ray-git

# Информация и состояние батареи
upower -i /org/freedesktop/UPower/devices/battery_BAT0

# Режим экономии заряда батареи (0 - выключить, 1 - включить)
echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode

# Либо использовать Electric ray для настройки батареи
```
### Пакеты

```
yay -S hyprland hyprlock xdg-desktop-portal-gtk xdg-desktop-portal-hyprland waybar kitty rofi-wayland gtklock waypaper-git swww dunst firefox clipse
```
### Waypaper

>[!info] Для работы новых функций нужно использовать **waypaper-git**

```
~/config/waypaper/config.ini
------------------------------------------------------------------------------
[Settings]
language = ru
folder = ~/Pictures
wallpaper = ~/Pictures/CXHJVNx5.png
backend = swww
monitors = All
fill = fill
sort = name
color = #ffffff
subfolders = False
show_hidden = False
show_gifs_only = False
post_command = 
number_of_columns = 3
swww_transition_type = fade
swww_transition_step = 90
swww_transition_angle = 0
swww_transition_duration = 2
swww_transition_fps = 60
------------------------------------------------------------------------------
```
### Звук

```
yay -S pipewire lib32-pipewire pipewire-alsa pipewire-pulse pavucontrol
```
### Шрифты

```
yay -S noto-fonts ttf-dejavu ttf-droid ttf-roboto ttf-liberation ttf-font-awesome ttf-nerd-fonts-symbols
```
### Диски

```
yay -S gnome-disk-utility qdiskinfo kdiskmark
```
### Проводник

```
yay -S thunar thunar-volman tumbler ffmpegthumbnailer thunar-media-tags-plugin thunar-archive-plugin gvfs gvfs-mtp udisks2 udiskie

yay -S nautilus gvfs gvfs-mtp udisks2 udiskie

~/.config/hypr/hyprland.conf
------------------------------------------------------------------------------
exec-once = udiskie &
------------------------------------------------------------------------------
```
### Nautilus

Сортировка файлов по типу по умолчанию :

```
gsettings set org.gnome.nautilus.preferences default-sort-order 'type'
```
### Архивы

```
yay -S file-roller lrzip unrar unzip unace p7zip squashfs-tools
```
### SDDM

```
yay -S sddm
systemctl enable sddm.service
```
### NeoVim

```
yay -S neovim wl-clipboard
```
### Информация о системе

```
neofetch pfetch-rs macchina
```
### Настройка персонализации

```
yay -S nwg-look qt6ct

# nwg-look --- GTK-приложения
# qt6ct --- Qt-приложения
```
### MIME Applications (Приложения по умолчанию)

Список приложений по умолчанию - `/usr/share/applications/mimeinfo.cache`

Пользовательский MIME-файл может находится в следующих местах :
```
~/.config/mimeapps.list
/usr/share/applications/mimeapps.list
```

Для того, чтобы настроить приложение по умолчанию используется утилита `gio` :
```
gio mime inode/directory org.gnome.Nautilus.desktop
```

`inode/diretory` - MIME-переменная, которая отвечает файловый менеджер по умолчанию.
### Игры

```
yay -S gamescope lutris mangohud lib32-mangohud goverlay vkbasalt
```

Для работы gamescope нужно включить Vkbasalt :

```
~/.config/hypr/hyprland.conf
------------------------------------------------------------------------------
env = ENABLE_VKBASALT,1
------------------------------------------------------------------------------
```
#### Выбор GPU

Чтобы узнать список GPU, использующих Vulkan, введите следующее :

```
MESA_VK_DEVICE_SELECT=list vulkaninfo
------------------------------------------------------------------------------
selectable devices:
  GPU 0: 10de:28e0 "NVIDIA GeForce RTX 4060 Laptop GPU" discrete GPU 0000:01:00.0
  GPU 1: 1002:15bf "AMD Radeon 780M (RADV GFX1103_R1)" integrated GPU 0000:06:00.0
```

Сама переменная работает очень странно. В источнике написано, что для выбора GPU нужно указать номер "vid:did". Но на деле выходит, что какой бы я номер не указал, всегда будет NVIDIA. 

В моём случае, чтобы выбрать интегрированный GPU, помогло добавление восклицательного знака в конец номера  :

```
MESA_VK_DEVICE_SELECT=1002:15bf! vkcube
------------------------------------------------------------------------------
Selected GPU 0: AMD Radeon 780M (RADV GFX1103_R1), type: IntegratedGpu
```

`!` знак влияет на переменную `MESA_VK_DEVICE_SELECT_FORCE_DEFAULT_DEVICE`.

> [!info] MESA_VK_DEVICE_SELECT_FORCE_DEFAULT_DEVICE 
> Если установлено значение 1, устройство, определенное как устройство по умолчанию, будет единственным возвращается в API vkEnumeratePhysicalDevices.
#### Gothic I / II

Для работы с игрой нужно поставить правильный Proton :

`Steam -> Настройки -> Совместимость -> Proton-7.0-6`
### Обход блокировки YouTube

#### SpoofDPI

>[!fail] На данный момент перестал работать

> SpoofDPI - это простое и быстрое ПО, созданное для обхода **Deep Packet Inspection**

```
yay -S spoof-dpi-bin
```

Создадим пользовательский unit, чтобы не вводить команду каждый раз после запуска системы :

```
~/.config/systemd/user/spoof-dpi.service
------------------------------------------------------------------------------
[Unit]
Description=SpoofDPI

[Service]
ExecStart=spoof-dpi

[Install]
WantedBy=default.target
------------------------------------------------------------------------------
systemctl enable --now --user spoof-dpi.service
```

Перезагружаем систему и проверяем работоспособность unit'а :

```
systemctl status --user spoof-dpi.service
```

Теперь нужно настроить Firefox. 
Переходим по следующему пути : Настройки > Основные > Настройки сети > Настроить Настраиваем так, как на скриншоте ниже :
![[firefox_net.png]]
#### zapret

```
git clone https://github.com/bol-van/zapret.git
./install_easy.sh
```

##### Конфиг :
```
#TMPDIR=/opt/zapret/tmp

#WS_USER=nobody

FWTYPE=iptables

SET_MAXELEM=522288

IPSET_OPT="hashsize 262144 maxelem $SET_MAXELEM"

#IPSET_HOOK="/etc/zapret.ipset.hook"

IP2NET_OPT4="--prefix-length=22-30 --v4-threshold=3/4"
IP2NET_OPT6="--prefix-length=56-64 --v6-threshold=5"

AUTOHOSTLIST_RETRANS_THRESHOLD=3
AUTOHOSTLIST_FAIL_THRESHOLD=3
AUTOHOSTLIST_FAIL_TIME=60
AUTOHOSTLIST_DEBUGLOG=0

MDIG_THREADS=30

GZIP_LISTS=1

#LISTS_RELOAD="pfctl -f /etc/pf.conf"

#HTTP_PORTS=80-81,85
#HTTPS_PORTS=443,500-501
#QUIC_PORTS=443,444

MODE=nfqws
MODE_HTTP=1
MODE_HTTP_KEEPALIVE=0
MODE_HTTPS=1
MODE_QUIC=1
MODE_FILTER=none

DESYNC_MARK=0x40000000
DESYNC_MARK_POSTNAT=0x20000000
NFQWS_OPT_DESYNC="--dpi-desync=fake,disorder2 --dpi-desync-split-pos=1 --dpi-desync-ttl=0 --dpi-desync-fooling=md5sig,badsum --dpi-desync-repeats=6 --dpi-desync-any-protocol --dpi-desync-cutoff=d4 --dpi-desync-fake-tls=/opt/zapret/files/fake/tls_clienthello_www_google_com.bin"
#NFQWS_OPT_DESYNC_SUFFIX=
#NFQWS_OPT_DESYNC_HTTP=
#NFQWS_OPT_DESYNC_HTTP_SUFFIX=
#NFQWS_OPT_DESYNC_HTTPS=
#NFQWS_OPT_DESYNC_HTTPS_SUFFIX=
#NFQWS_OPT_DESYNC_HTTP6=
#NFQWS_OPT_DESYNC_HTTP6_SUFFIX=
#NFQWS_OPT_DESYNC_HTTPS6=
#NFQWS_OPT_DESYNC_HTTPS6_SUFFIX=
NFQWS_OPT_DESYNC_QUIC="--dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-ttl=0 --dpi-desync-any-protocol --dpi-desync-cutoff=d4 --dpi-desync-fooling=md5sig,badsum --dpi-desync-fake-quic=/opt/zapret/files/fake/quic_initial_google_com.bin"
#NFQWS_OPT_DESYNC_QUIC_SUFFIX=
#NFQWS_OPT_DESYNC_QUIC6=
#NFQWS_OPT_DESYNC_QUIC6_SUFFIX=

TPWS_OPT="--hostspell=HOST --split-http-req=method --split-pos=3 --oob"
#TPWS_OPT_SUFFIX="--mss 88"

FLOWOFFLOAD=donttouch

#OPENWRT_LAN="lan lan2 lan3"

#OPENWRT_WAN4="wan vpn"
#OPENWRT_WAN6="wan6 vpn6"

#IFACE_LAN=eth0
IFACE_WAN=wlo1
#IFACE_WAN6="ipsec0 wireguard0 he_net"

INIT_APPLY_FW=1

#INIT_FW_PRE_UP_HOOK="/etc/firewall.zapret.hook.pre_up"
#INIT_FW_POST_UP_HOOK="/etc/firewall.zapret.hook.post_up"
#INIT_FW_PRE_DOWN_HOOK="/etc/firewall.zapret.hook.pre_down"
#INIT_FW_POST_DOWN_HOOK="/etc/firewall.zapret.hook.post_down"

#DISABLE_IPV4=1

DISABLE_IPV6=0

GETLIST=get_user.sh
```

##### get_user.sh :
```
rutracker.cc
googleapis.com
googleusercontent.com
googlevideo.com
gstatic.com
nhacmp3youtube.com
www.youtube.com
youtu.be
youtube.com
youtubei.googleapis.com
yt4.ggpht.com
ytimg.com
ytimg.l.google.com
x.com
twimg.com
t.co
twitter.com
rutor.info
rutracker.org
instagram.com
cdninstagram.com
ig.me
donmai.us
facebook.com
fbcdn.net
facebook.net
fbsbx.com
fbpigeon.com
fb.com
fb.gg
discord.com
gateway.discord.gg
cdn.discordapp.com
discordapp.net
discordapp.com
discord.gg
media.discordapp.net
images-ext-1.discordapp.net
www.discord.com
www.discord.app
discord.app
*.discord.com
*.discord.gg
*.discordapp.com
*.discordapp.net
discord.media
*.discord.media
discordcdn.com
discord.dev
discord.new
discord.gift
discordstatus.com
dis.gd
discord.com
```