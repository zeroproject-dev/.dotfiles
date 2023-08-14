#!/bin/sh

set -e

username="$USER"
userhome="$HOME"

command_exists() {
	command -v "$1" >/dev/null 2>&1
}

sudo pacman -S --needed base-devel

# later config lxappearance qt5ct
BASE_BSPWM="bspwm sxhkd polybar rofi feh picom udiskie scrot dunst network-manager-applet ttf-hack-nerd polkit-gnome xorg-xsetroot playerctl pamixer"
TERMINAL="alacritty zsh lsd bat ttf-victor-mono-nerd kitty"
CODE="tmux neovim clang ttf-cascadia-code"

if ! command_exists "git"; then
	sudo pacman -S --noconfirm git
fi

if ! command_exists "bspwm"; then
	sudo pacman -S --noconfirm $BASE_BSPWM
	install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
	install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc
fi

sudo pacman -S --noconfirm $TERMINAL $CODE ranger ueberzug xorg-xclipboard xclip
sudo pacman -S --noconfirm gnu-free-fonts noto-fonts ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid ttf-ibm-plex ttf-liberation

# Installing rust and dependencies
if ! command_exists "cargo"; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	source $userhome/.cargo/env
fi

export PATH="$HOME/.cargo/bin:$PATH"
cargo install dotz
cargo install fnm
cargo install tree-sitter-cli

# installing paru (AUR helper)
if ! command_exists "paru"; then
	git clone https://aur.archlinux.org/paru.git /tmp
	cd /tmp/paru
	makepkg -si
fi

# Installing configuration
rm -rf $userhome/.dotfiles
dotz repo https://github.com/zeroproject-0/.dotfiles.git $userhome/.dotfiles $userhome
cd $userhome/.dotfiles && git submodule update --init --recursive

paru -S zomodoro visual-studio-code-bin microsoft-edge-stable emote colorpicker

# installing tmux tmp
rm -rf $userhome/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm $userhome/.tmux/plugins/tpm

# installing oh my zsh
export RUNZSH=no
rm -rf $userhome/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installation are finished"
echo "------------------------------------"
echo ""
echo "Uncomment \"#Color\" -> \"Color\" from /etc/pacman.conf for color highlighting in paru"
echo ""
echo "For install tmux plugins enter a tmux session and press CTRL+b and shift+i"
echo ""
echo "If android emulators of android studio goes slow execute:"
echo "\$  echo \"QuickbootFileBacked = off\" >> ~/.android/advancedFeatures.ini"
echo "more info on https://www.reddit.com/r/btrfs/comments/l8qu3l/android_emulator_is_unusable_on_btrfs_partition/"
