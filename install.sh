#!/bin/sh

# if [[ $EUID -ne 0 ]]; then
# 	echo "Run this script with a super user"
# 	exit 1
# fi

set -e

username="$USER"
userhome="$HOME"

command_exists() {
	command -v "$1" >/dev/null 2>&1
}

sudo pacman -S --needed base-devel

# later config lxappearance qt5ct
BASE_BSPWM="bspwm sxhkd polybar rofi feh picom udiskie scrot dunst network-manager-applet"
TERMINAL="alacritty zsh lsd bat ttf-victor-mono-nerd kitty"
CODE="tmux neovim clang ttf-cascadia-code"

if ! command_exists "git"; then
	sudo pacman -S git
fi

if ! command_exists "bspwm"; then
	sudo pacman -S $BASE_BSPWM
	install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
	install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc
fi

sudo pacman -S $TERMINAL $CODE ranger ueberzug playerctl xorg-xclipboard xclip
sudo pacman -S gnu-free-fonts noto-fonts ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid ttf-ibm-plex ttf-liberation

# Installing rust and dependencies
if ! command_exists "cargo"; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

cargo install dotz
cargo install fnm
cargo install tree-sitter-cli

# installing paru (AUR helper)
if ! command_exists "paru"; then
	git clone https://aur.archlinux.org/paru.git /tmp/
	cd /tmp/paru
	makepkg -si
fi

# Change default shell to zsh
sudo chsh /bin/zsh $username

# Installing configuration
dotz repo https://github.com/zeroproject-0/.dotfiles.git $userhome/.dotfiles $userhome
cd $userhome/.dotfiles && git submodule update --init --recursive

paru -S visual-studio-code-bin microsoft-edge-stable

# installing oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# installing tmux tmp
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Uncomment \"#Color\" -> \"Color\" from /etc/pacman.conf for color highlighting in paru"
echo "For install tmux plugins enter a tmux session and press CTRL+b and shift+i"