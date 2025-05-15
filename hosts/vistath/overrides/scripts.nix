{ pkgs, ... }:
# Brightness and volume scripts
let
  # Thanks for the ArchWiki for this awesome script
  volume = pkgs.writeShellScript "volume" ''
    get_volume() {
      volume=$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2 * 100}')
      echo "$volume"
    }
    get_icon() {
      current=$(get_volume)
      if [[ "$current" -eq "0" ]]; then
        echo audio-volume-low-zero
      elif [[ ("$current" -ge "0") && ("$current" -le "30") ]]; then
        echo audio-volume-low
      elif [[ ("$current" -ge "30") && ("$current" -le "60") ]]; then
        echo audio-volume-medium
      elif [[ ("$current" -ge "60") && ("$current" -le "100") ]]; then
        echo audio-volume-high
      fi
    }
    notify_user() {
      notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "Volume : $(get_volume) %"
    }
    inc_volume() {
      wpctl set-volume @DEFAULT_SINK@ 0.05+ && notify_user
    }
    dec_volume() {
      wpctl set-volume @DEFAULT_SINK@ 0.05- && notify_user
    }
    toggle_mute() {
      if [ "$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $3}')" == "" ]; then
        wpctl set-mute @DEFAULT_SINK@ 1 && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i audio-volume-muted "Muted"
      elif [ "$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $3}')" == "[MUTED]" ]; then
        wpctl set-mute @DEFAULT_SINK@ 0 && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "Unmuted"
      fi
    }
    if [[ "$1" == "--get" ]]; then
      get_volume
    elif [[ "$1" == "--inc" ]]; then
      inc_volume
    elif [[ "$1" == "--dec" ]]; then
      dec_volume
    elif [[ "$1" == "--toggle" ]]; then
      toggle_mute
    elif [[ "$1" == "--get-icon" ]]; then
      get_icon
    else
      get_volume
    fi
  '';

  brightness = pkgs.writeShellScript "brightness" ''
    get_backlight() {
      LIGHT=$(brightnessctl get | awk '{printf "%d", $0 / 960}')
      echo $LIGHT
    }
    get_icon() {
      current="$(get_backlight)"
      if [[ ("$current" -ge "0") && ("$current" -le "20") ]]; then
    	icon="weather-tornado"
      elif [[ ("$current" -ge "20") && ("$current" -le "40") ]]; then
    	icon="weather-clear-night"
      elif [[ ("$current" -ge "40") && ("$current" -le "60") ]]; then
    	icon="brightness-low"
      elif [[ ("$current" -ge "60") && ("$current" -le "80") ]]; then
    	icon="brightness-high"
      elif [[ ("$current" -ge "80") && ("$current" -le "100") ]]; then
        icon="weather-clear"
      fi
    }
    notify_user() {
      notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "Brightness : $(get_backlight)%"
    }
    inc_backlight() {
      brightnessctl set 5%+ && get_icon && notify_user
    }
    dec_backlight() {
      brightnessctl set 5%- && get_icon && notify_user
    }
    if [[ "$1" == "--get" ]]; then
      get_backlight
    elif [[ "$1" == "--inc" ]]; then
      inc_backlight
    elif [[ "$1" == "--dec" ]]; then
      dec_backlight
    else
      get_backlight
    fi
  '';

  clipboard = pkgs.writeShellScript "clipmenu" ''
    cliphist list | rofi -dmenu | cliphist decode | wl-copy
    wl-paste
  '';
in
{
  inherit
    volume
    brightness
    clipboard
    ;
}
