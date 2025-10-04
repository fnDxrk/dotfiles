#!/bin/bash

THEME_PATH="$HOME/.config/rofi/themes/wifi.rasi"

notify-send "Список сетей" "Получение списка доступных Wi-Fi сетей..."

wifi_list=$(LANG=C nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

connected=$(LANG=C nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
    toggle="󰖪  Отключить Wi-Fi"
    options="$toggle\n$wifi_list"
elif [[ "$connected" =~ "disabled" ]]; then
    toggle="󰖩  Включить Wi-Fi"
    options="$toggle"
fi

chosen_network=$(echo -e "$options" | uniq -u | rofi -dmenu -p "Wi-Fi SSID:" -theme "$THEME_PATH")

read -r chosen_id <<< "${chosen_network:3}"

if [ -z "$chosen_network" ]; then
    exit
elif [ "$chosen_network" = "󰖩  Включить Wi-Fi" ]; then
    nmcli radio wifi on
    notify-send "Wi-Fi Включён" "Радиомодуль Wi-Fi включён."
elif [ "$chosen_network" = "󰖪  Отключить Wi-Fi" ]; then
    nmcli radio wifi off
    notify-send "Wi-Fi Отключён" "Радиомодуль Wi-Fi отключён."
else
    success_message="Вы успешно подключились к Wi-Fi сети \"$chosen_id\"."
    error_message="Не удалось подключиться к Wi-Fi сети \"$chosen_id\"."

    saved_connections=$(LANG=C nmcli -g NAME connection)

    if [[ "$saved_connections" =~ (^|$'\n')"${chosen_id}"($|$'\n') ]]; then
        # Пытаемся подключиться к известной сети
        if LANG=C nmcli connection up id "$chosen_id" | grep -q "successfully"; then
            notify-send "Подключение установлено" "$success_message"
        else
            # Удаляем сеть из сохранённых, если подключение не удалось
            nmcli connection delete id "$chosen_id"
            notify-send "Ошибка подключения" "$error_message"
        fi
    else
        # Запрашиваем пароль, если сеть защищена
        if [[ "$chosen_network" =~ "" ]]; then
            wifi_password=$(rofi -dmenu -p "Пароль:" -theme "$THEME_PATH")
        fi

        # Пытаемся подключиться к новой сети
        if LANG=C nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep -q "successfully"; then
            notify-send "Подключение установлено" "$success_message"
        else
            # Удаляем сеть из сохранённых, если подключение не удалось
            nmcli connection delete id "$chosen_id"
            notify-send "Ошибка подключения" "$error_message"
        fi
    fi
fi
