#!/bin/bash

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
CONFIG=~/.config/hypr/hyprland.conf
MONITOR=""

get_monitor() {
  MONITOR=$(hyprctl monitors all | grep -oP '^Monitor \K\S+' | grep -v '^eDP' | head -n1)
}

switch_gpu() {
  get_monitor
  if [ -n "$MONITOR" ]; then
    sed -i "s|env = AQ_DRM_DEVICES.*|env = AQ_DRM_DEVICES,/dev/dri/nvidia-dgpu:/dev/dri/amd-igpu|" "$CONFIG"
  else
    sed -i "s|env = AQ_DRM_DEVICES.*|env = AQ_DRM_DEVICES,/dev/dri/amd-igpu:/dev/dri/nvidia-dgpu|" "$CONFIG"
  fi
  hyprctl reload
}

handle() {
  case $1 in
  monitoradded*"$MONITOR" | monitorremoved*"$MONITOR")
    switch_gpu
    hyprctl dispatch exit
    ;;
  esac
}

switch_gpu

socat -U - "UNIX-CONNECT:$SOCKET" | while read -r line; do handle "$line"; done
