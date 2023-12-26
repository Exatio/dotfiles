#!/bin/sh

symlinkFile() {
    filename="$SCRIPT_DIR/$1"
    destination="$HOME/$2/$1"

    mkdir -p $(dirname "$destination")

    if [ ! -L "$destination" ]; then
        if [ -e "$destination" ]; then
            echo "[ERROR] $destination exists but it's not a symlink. Please fix that manually" && exit 1
        else
            ln -s "$filename" "$destination"
            echo "[OK] $filename -> $destination"
        fi
    else
        echo "[WARNING] $filename already symlinked"
    fi
}

_isInstalledYay() {
    package="$1";
    check="$(yay -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return;
    fi;
    echo 1; #'1' means 'false' in Bash
    return;
}


_installPackages() {
    for pkg; do
        if [[ $(_isInstalledYay "${pkg}") == 1 ]]; then
            echo "-------------------- Installing $pkg... --------------------"
            yay -S --noconfirm "$pkg"
        fi        
    done

    for pkg; do
        if [[ $(_isInstalledYay "${pkg}") == 1 ]]; then
            echo "$pkg couldn't be installed..."        
        fi        
    done
}


# ------------------------------------------------------
# Packages list
# ------------------------------------------------------

HYPRLAND="Hyprland";
hyprland=(
    "hyprland-git" 
    "xdg-desktop-portal"
    "xdg-desktop-portal-hyprland"
);

SDDM="Display Manager";
sddm=(
    "sddm-git"
    "sddm-theme-tokyo-night"
);

BARS="Status bar";
bars=(
    "eww-git"
    "waybar"
    "wttrbar"
);

WALLS="Wallpapers";
wallpapers=(
    "swww"
    "python-pywal"
);

BROWS="Browsers";
browsers=(
    "chromium"
#   "brave-bin"
    "floorp"
);

POW="Power menu";
pow=(
    "swayidle"
    "sway-audio-idle-inhibit-git"
    "swaylock-effects-git"
    "wlogout"
);

APPL="Application Launcher";
appLauncher=(
    "tofi"
);

NOTIF="Notifications";
notifications=(
    "dunst"
    "libnotify"
);

TERMS="Terminal emulators";
term=(
    "alacritty"
    "kitty"
);    

SCREENSHOTS="Screenshots";
screenshots=(
    "grim"
    "slurp"
    "swappy"
);

CLIPB="Clipboard management";
clip=(
    "cliphist"
    "wl-clipboard"
    "wl-clip-persist-git"
);

EDIT="Editor";
editors=(
    "emacs-wayland"
    "vim"
    "neovim"
    "mousepad"
    "nano"
);

NETW="Network Management";
network=(
    "network-manager-applet"
    "nm-connection-editor"
);

SHELLS="Shells";
shells=(
    "zsh"
);

GTKSTUFF="GTK stuff";
gtk=(
    "nwg-look-bin"
    "catppuccin-gtk-theme-mocha"
    "bibata-cursor-theme-bin"
);


SOUND="Sound management / Music";
sound=(
    "mpv"
    "playerctl"
    "cava"
    "pavucontrol"
    "pamixer"
    "pipewire"
    "pipewire-audio"
    "pipewire-alsa"
    "pipewire-pulse"
    "pipewire-jack"
    "wireplumber"
);

UTILS="Utilities";
utils=(
    "eza" # better ls
    "bat" # better cat
    "python"
    "python-pip"
    "pfetch" # neofetch alternative
    "polkit-kde-agent" # policy kit
    "kdeconnect" # connect to phone
    "viewnior" # fast & Elegant image viewer
    "vlc"
    "xdg-user-dirs" # Downloads, Pictures, ... folders
    "qt5ct" # QT settings editor
    "pacman-contrib"
    "wget"
    "unzip"
    "timeshift" # System snapshots
    "wlsunset" # Day/Night gamma adjustement
    "brightnessctl" # Screen brightness
    # Battery management
    "acpi"
    "xfce4-power-manager"
    # Hardware monitor
    "btop"
    "gnome-system-monitor" # Windows-like btop
    "nvtop" # btop but for GPUs 
);

FONTS="Fonts";
fonts=(
    "adobe-source-code-pro-fonts"
    "noto-fonts-emoji"
    "otf-font-awesome"
    "otf-font-awesome-4"
    "ttf-droid"
    "ttf-jetbrains-mono"
    "ttf-jetbrains-mono-nerd"
    "ttf-font-awesome"
    "ttf-fira-sans"
    "ttf-firacode-nerd"
    "cantarell-fonts"
    "ttf-iosevka-nerd"
    "ttf-meslo-nerd-font-powerlevel10k"
    "otf-font-awesome"
    "otf-font-awesome-4"
);

BLUETOOTH="Bluetooth";
bluetooth=(
    "bluez"
    "bluez-utils"
    "blueman"
);

THUNAR="Thunar";
thunar=(
    "thunar"
    "thunar-volman"
    "tumbler"
    "thunar-archive-plugin"
    "gvfs"
);

