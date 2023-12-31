#!/bin/bash

iDIR="$HOME/.config/dunst/icons"
time=$(date +%Y-%m-%d-%H-%M-%S)
dir="$(xdg-user-dir)/Images/screenshots"
file="Capture_${time}_${RANDOM}.png"

notify_cmd_shot="notify-send -h string:x-canonical-private-synchronous:shot-notify -u low -i ${iDIR}/picture.png"


if [[ ! $(pidof tofi) ]]; then

	if [[ ! -d "$dir" ]]; then
		mkdir -p "$dir"
	fi	

	option1="Area"
	option2="Fullscreen"
	option3="Window"

	options="$option1\n$option2\n$option3"

	choice=$(echo -e "$options" | tofi -c ~/.config/tofi/config-screenshot)
	
	if [ -z "$choice" ]; then
		echo "Nothing selected or an error occurred."
		exit 1
	fi

	case $choice in
	    $option1)
		grim -g "$(slurp)" - | swappy -f -
	    ;;
	    $option2)
		cd ${dir} && grim - | tee "$file" | wl-copy
		sleep 2
		notify_view
	    ;;
	    $option3)
		sleep 1
		w_pos=$(hyprctl activewindow | grep 'at:' | cut -d':' -f2 | tr -d ' ' | tail -n1)
		w_size=$(hyprctl activewindow | grep 'size:' | cut -d':' -f2 | tr -d ' ' | tail -n1 | sed s/,/x/g)
		cd ${dir} && grim -g "$w_pos $w_size" - | tee "$file" | wl-copy
		notify_view
	    ;;
	esac

else
	pkill tofi
fi




