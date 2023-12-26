#!/bin/sh

# Installer and dots based on :
# https://gitlab.com/stephan-raabe/dotfiles/
# https://github.com/prasanthrangan/hyprdots
# https://github.com/linkfrg/dotfiles
# https://github.com/end-4/dots-hyprland

SCRIPT_DIR="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"
source ./.install/packages.sh

echo "-------- EXATIO ARCH INSTALLER --------"
echo
echo "Hello, and welcome to this installer file."
echo "For the necessary programs to be installed, it will ask you for your password."
echo "Feel free to navigate through the source code to check if everything is at your conveniance."
echo "credits here" # TODO

# ------------------------------------------------------
# Gum install for beautiful terminal interface
# ------------------------------------------------------
sudo pacman -S gum --noconfirm

# ------------------------------------------------------
# Confirm Start
# ------------------------------------------------------
if ! gum confirm "Are you sure you want to start the installation now ?"; then
    echo "Installation aborted."
    exit 1
fi

# ------------------------------------------------------
# Yay install
# ------------------------------------------------------
echo "Installing yay..."
if sudo pacman -Qs yay > /dev/null ; then
    echo "yay is already installed"
else
    echo "yay is not installed - installing now."
    gum spin -s line --title "Installing base-devel..." --\
        sudo pacman -S --noconfirm "base-devel"
    gum spin -s line --title "Cloning yay-bin..." --\
        git clone https://aur.archlinux.org/yay-bin.git ~/yay-bin
    cd ~/yay-bin
    gum spin -s line --title "Making & Installing yay..." --\
        makepkg -si --noconfirm 2>&1
    cd ~/dotfiles/
    gum spin -s line --title "Updating your system..." --\
        yay -Syu --noconfirm
fi
echo ""

# ------------------------------------------------------
# Installing packages
# ------------------------------------------------------
if gum confirm "Do you want to install all my packages ?"; then
    
    ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] "\
        --no-limit "$HYPRLAND" "$BARS" "$BROWS" "$POW" "$APPL" "$NOTIF" "$TERMS" "$SCREENSHOTS" "$CLIPB" "$EDIT" "$NETW" "$SHELLS" "$GTKSTUFF" "$SOUND" "$UTILS" "$FONTS" "$THUNAR"\
        --selected "$HYPRLAND"\
        --selected "$BARS"\
        --selected "$BROWS"\
        --selected "$POW"\
        --selected "$APPL"\
        --selected "$NOTIF"\
        --selected "$TERMS"\
        --selected "$SCREENSHOTS"\
        --selected "$CLIPB"\
        --selected "$EDIT"\
        --selected "$NETW"\
        --selected "$SHELLS"\
        --selected "$GTKSTUFF"\
        --selected "$SOUND"\
        --selected "$UTILS"\
        --selected "$FONTS"\
        --selected "$THUNAR"\
    )

    grep -q "$HYPRLAND" <<< "$ACTIONS" && _installPackages "${hyprland[@]}"
    grep -q "$BARS" <<< "$ACTIONS" && _installPackages "${bars[@]}"
    grep -q "$BROWS" <<< "$ACTIONS" && _installPackages "${browsers[@]}"
    grep -q "$POW" <<< "$ACTIONS" && _installPackages "${pow[@]}"
    grep -q "$APPL" <<< "$ACTIONS" && _installPackages "${appLauncher[@]}"
    grep -q "$NOTIF" <<< "$ACTIONS" && _installPackages "${notifications[@]}"
    grep -q "$TERMS" <<< "$ACTIONS" && _installPackages "${term[@]}"
    grep -q "$SCREENSHOTS" <<< "$ACTIONS" && _installPackages "${screenshots[@]}"
    grep -q "$CLIPB" <<< "$ACTIONS" && _installPackages "${clip[@]}"
    grep -q "$EDIT" <<< "$ACTIONS" && _installPackages "${editors[@]}"
    grep -q "$NETW" <<< "$ACTIONS" && _installPackages "${network[@]}"
    grep -q "$SHELLS" <<< "$ACTIONS" && _installPackages "${shells[@]}"
    grep -q "$GTKSTUFF" <<< "$ACTIONS" && _installPackages "${gtk[@]}"
    grep -q "$SOUND" <<< "$ACTIONS" && _installPackages "${sound[@]}"
    grep -q "$UTILS" <<< "$ACTIONS" && _installPackages "${utils[@]}"
    grep -q "$FONTS" <<< "$ACTIONS" && _installPackages "${fonts[@]}"
    grep -q "$THUNAR" <<< "$ACTIONS" && _installPackages "${thunar[@]}"
    
    sleep 1
fi

# ------------------------------------------------------
# Enable bluetooth
# ------------------------------------------------------
if gum confirm "Do you want to enable & setup bluetooth ?"; then
    _installPackages "${bluetooth[@]}"
    sudo systemctl enable --now bluetooth.service
fi

# ------------------------------------------------------
# Setup SDDM
# ------------------------------------------------------
if gum confirm "Do you want to install & enable SDDM with my theme ?"; then
    _installPackages "${sddm[@]}"
    sudo systemctl enable sddm
    echo -e "[Theme]\nCurrent=tokyo-night-sddm" | sudo tee -a "/etc/sddm.conf"
    sudo localectl set-keymap fr # TODO: prompt what locale
fi

if gum confirm "Do you want to have my wallpapers ?"; then
    if [ -d ~/wallpapers/ ]; then
        echo "The ~/wallpapers/ folder already exists."
    else
        mkdir ~/wallpapers
        echo "~/wallpapers/ folder created!"
    fi
    cp $SCRIPT_DIR/wallpapers/* ~/wallpapers
    echo "Wallpapers were copied."
fi

# ------------------------------------------------------
# Installing symlinks
# ------------------------------------------------------
for row in $(cat $SCRIPT_DIR/.install/MANIFEST); do
    filename=$(echo $row | cut -d \| -f 1)
    operation=$(echo $row | cut -d \| -f 2)
    destination=$(echo $row | cut -d \| -f 3)

    case $operation in
        symlink)
            if gum confirm "Do you want to symlink $filename ?"; then
                symlinkFile $filename $destination
            fi
            ;;
        copy)
            if gum confirm "Do you want to copy $filename ?"; then
                symlinkFile $filename $destination
            fi
            ;;
        *)
            echo "[WARNING] Unknown operation $operation. Skipping..."
            ;;
    esac
done

# ------------------------------------------------------
# Installing GTK symlinks
# ------------------------------------------------------
if gum confirm "Do you want to symlink my GTK settings ?"; then
    ln -sf $SCRIPT_DIR/gtk/.gtkrc-2.0 ~/.gtkrc-2.0
    ln -sf $SCRIPT_DIR/gtk/.Xresources ~/.Xresources
    ln -sf $SCRIPT_DIR/gtk/gtk-3.0/ ~/.config/
    ln -sf $SCRIPT_DIR/gtk/gtk-4.0/ ~/.config/
fi

# Install that ?

# wget https://github.com/ljmill/tokyo-night-icons/releases/download/v0.2.0/TokyoNight-SE.tar.bz2
# mkdir -p ~/.icons
# tar -xvjf TokyoNight-SE.tar.bz2 -C ~/.icons
# mkdir -p ~/.themes
# unzip -q ".tokyo-themes/Tokyonight-Dark-B.zip" -d ~/dotfiles/tokyo-themes || true
# unzip -q ".tokyo-themes/Tokyonight-Light-B.zip" -d ~/dotfiles/tokyo-themes || true
# ln -sf Tokyonight-Dark-B ~/.config/themes ~/dotfiles/tokyo-themes/Tokyonight-Dark-B/ ~/.themes
# ln -sf Tokyonight-Light-B ~/.config/themes ~/dotfiles/tokyo-themes/Tokyonight-Light-B/ ~/.themes


# ------------------------------------------------------
# Installing pywal
# ------------------------------------------------------
if gum confirm "Do you want to install & setup pywal?"; then
    _installPackages "${wallpapers[@]}";
    symlinkFile wal .config
    wal -i $SCRIPT_DIR/wallpapers/default.jpg
fi


# ------------------------------------------------------
# Setup ZSH
# ------------------------------------------------------
if gum confirm "Do you want to install & setup ZSH?"; then
    _installPackages "zsh";
    
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search    
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    
    ln -sf $SCRIPT_DIR/.zshrc ~/
fi


if command -v sddm >/dev/null; then
    sudo systemctl start sddm
else
    if command -v Hyprland >/dev/null; then
        exec Hyprland
    else
        echo "${ERROR} Hyprland not found. Please make sure Hyprland is installed by checking install logs"
    fi
fi
