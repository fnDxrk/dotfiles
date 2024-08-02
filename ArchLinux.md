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
options	root="LABEL=Arch" rw quiet splash loglevel=3 udev.log_level=3 zswap.enabled=0 nvidia-drm.modeset=1
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
## Yay

```
git clone https://aur.archlinux.org/yay-bin
cd yay-bin
makepkg -si
cd && rm -rf yay-bin
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

## Polkit

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
## Nvidia

```
yay -S nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader nvidia-prime mesa-utils linux-headers dkms 

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

## Батарея

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
yay -S hyprland waybar kitty rofi-wayland gtklock waypaper dunst firefox
```
### Звук

```
yay -S pipewire lib32-pipewire pipewire-alsa pipewire-pulse pavucontrol
```
### Шрифты

```
yay -S noto-fonts ttf-dejavu ttf-droid ttf-roboto ttf-liberation ttf-font-awesome ttf-nerd-fonts-symbols
```
### Проводник

```
yay -S thunar thunar-volman thunar-media-tags-plugin thunar-archive-plugin gvfs gvfs-mtp udisks2 udiskie

~/.config/hypr/hyprland.conf
------------------------------------------------------------------------------
exec-once = udiskie &
------------------------------------------------------------------------------
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
neofetch pfetch macchina
```

## Настройка персонализации

```
yay -S nwg-look qt6ct

# nwg-look --- GTK-приложения
# qt6ct --- Qt-приложения
```
