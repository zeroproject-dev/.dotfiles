#!/bin/sh

set -e

# HELPERS
username=$USER
userhome=$HOME
export PATH="$HOME/.cargo/bin:$PATH"

# Check if a command exists
#
# @param $1=command string The command to check
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

print_green() {
  printf "\033[0;32m%s\033[0m\n" "$1"
}

print_red() {
  printf "\033[0;31m%s\033[0m\n" "$1"
}

print_blue() {
  printf "\033[0;34m%s\033[0m\n" "$1"
}

print_gray() {
  printf "\033[0;37m%s\033[0m\n" "$1"
}

handle_error() {
  print_red "$1"
  exit 1
}

# Print confirmation message
#
# @param question string The question to ask the user (default: "Do you want to continue? (y/n)")
# @return 1 if the user responds with "n", 0 otherwise
print_confirmation() {
  question=${1:-"Do you want to continue? (y/n) "}
  print_blue "$question"

  read -r response
  if [ "$response" != "y" ] && [ "$response" != "" ]; then
    return 1
  else
    return 0
  fi
}

# Install a package
#
# @param package_name string The name of the package
# @param package_command string The command to install the package
# @param post_install_commands string The commands to run after the package is installed
# @return void
install_package() {
  package_name=$1
  package_command=$2
  post_install_commands=$3

  if print_confirmation "Do you want to install $package_name? (y/n)"; then
    print_green "Installing $package_name"
    eval "$package_command"
    eval "$post_install_commands"
  else
    print_blue "Skip $package_name installation"
  fi
}

# END HELPERS

# Install required packages
print_blue "Installing required packages"

print_green "Installing base-devel"
sudo pacman -S --needed base-devel

if ! command_exists "git"; then
  print_green "Installing git"
  sudo pacman -S --noconfirm git
else
  print_blue "Git already installed"
fi

# Installing rust
if ! command_exists "cargo"; then
  print_green "Installing rust"
  sudo pacman -S --noconfirm rustup
  rustup default stable
else
  print_blue "Rust already installed"
fi

cargo install dotz
cargo install tree-sitter-cli

# installing paru (AUR helper)
if ! command_exists "paru"; then
  print_green "Installing paru"
  cargo install --git https://github.com/Morganamilo/paru.git 2>/dev/null

  if ! command_exists "paru"; then
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    cd /tmp/paru
    makepkg -si
  fi

  sudo sed -i 's/#Color/Color/' /etc/pacman.conf

else
  print_blue "Paru already installed"
fi

# Installing bspwm
print_green "Installing environment (bspwm)"

sudo pacman -S --noconfirm bspwm sxhkd polybar rofi feh picom udiskie scrot dunst network-manager-applet polkit-gnome xorg-xsetroot playerctl pamixer xorg-xrandr pavucontrol xorg-xclipboard xclip xsel unzip htop fastfetch ntfs-3g

paru -Sy --noconfirm zomodoro x11-emoji-picker colorpicker i3lock-fancy-rapid-git boomer-git

# Rofi as dmenu
sudo ln -s /usr/bin/rofi /usr/bin/dmenu

#NOTE:
# Removed: alacritty ranger ueberzug
print_green "Installing terminal tools"
sudo pacman -S --noconfirm zsh lsd bat kitty starship tmux man-db yazi ffmpegthumbnailer p7zip jq poppler fd ripgrep fzf zoxide imagemagick

print_green "Installing fonts"
sudo pacman -S --noconfirm gnu-free-fonts noto-fonts ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid ttf-ibm-plex ttf-liberation ttf-cascadia-code ttf-victor-mono-nerd ttf-hack-nerd

print_green "Installing configuration tools"
sudo pacman -S --noconfirm lxappearance qt5ct breeze breeze-gtk

# installing oh my zsh
print_green "Installing oh-my-zsh"
export RUNZSH=no
rm -rf "$userhome/.oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# installing dotfiles
print_green "Installing dotfiles"
rm -rf "$userhome/.dotfiles"
dotz repo https://github.com/zeroproject-dev/.dotfiles.git "$userhome/.dotfiles" "$userhome"
cd "$userhome/.dotfiles" && git submodule update --init --recursive

install -Dm755 "$userhome/.dotfiles/.config/bspwm/bspwmrc" "$userhome/.config/bspwm/bspwmrc"
install -Dm644 "$userhome/.dotfiles/.config/sxhkd/sxhkdrc" "$userhome/.config/sxhkd/sxhkdrc"

dotz -f "$userhome/.dotfiles"

# installing tmux tmp
print_green "Installing tmux tmp"
rm -rf "$userhome/.tmux/plugins/tpm"
git clone https://github.com/tmux-plugins/tpm "$userhome/.tmux/plugins/tpm"
rm -rf "$userhome/.tmuxifier"
git clone https://github.com/jimeh/tmuxifier.git "$userhome/.tmuxifier"

print_blue "Installing code packages"

# Visual studio code
install_package "visual studio code" "paru -Sy --noconfirm visual-studio-code-bin" ""

install_package "Neovim" "sudo pacman -S --noconfirm neovim tidy lazygit" ""

install_package "Android Studio" "paru -Sy --noconfirm android-studio" ""

install_package "Github CLI" "sudo pacman -S --noconfirm github-cli" ""

if print_confirmation "Do you want to install nodejs? (y/n)"; then
  print_green "Installing nodejs"
  cargo install fnm
  eval "$(fnm env)"
  node_version=$(curl -sL https://nodejs.org/dist/latest/SHASUMS256.txt | grep "node-v" | awk '{print $2}' | sed 's/node-v//' | head -1 | sed 's/\..*//' | xargs)
  print_green "Node version: $node_version"
  fnm use --install-if-missing "$node_version"
else
  print_blue "skip nodejs installation"
fi

if print_confirmation "Do you want to install python? (y/n)"; then
  print_green "Installing python"
  sudo pacman -S --noconfirm pyenv python-pipx
  version=$(pyenv install -l | grep -P "^ *\d[\d|\.]*\d$" | tail -1)
  print_green "Python version: $version"
  pyenv install "$(echo "$version" | xargs)"
  pyenv global "$(echo "$version" | xargs)"
  pipx install poetry
else
  print_blue "skip python installation"
fi

install_package "C/C++" "sudo pacman -S --noconfirm gcc gdb clang lldb" ""

install_package "C#" "paru -Sy --noconfirm dotnet-runtime dotnet-sdk aspnet-runtime" ""

install_package "Go lang" "sudo pacman -S --noconfirm go" ""

install_package "Java" "sudo pacman -Sy --noconfirm jdk-openjdk && sudo pacman -Su --noconfirm" ""

install_package "Flutter" "paru -Sy --noconfirm fvm" ""

install_package "Docker" "sudo pacman -S --noconfirm docker docker-compose && paru -Sy --noconfirm lazydocker" "sudo systemctl enable docker && sudo usermod -aG docker $username"

print_blue "Installing utilities"

install_package "Remmina" "sudo pacman -S --noconfirm remmina freerdp" ""

install_package "VLC player" "sudo pacman -S --noconfirm vlc" ""

install_package "Microsoft Edge" "paru -Sy --noconfirm microsoft-edge-stable" ""

install_package "Firefox" "sudo pacman -S --noconfirm firefox" ""

install_package "NoiseTorch" "paru -S --noconfirm noisetorch-bin" ""

install_package "Dbeaver" "paru -S --noconfirm dbeaver" ""

install_package "Thunar filemanager" "paru -S --noconfirm thunar thunar-volman" ""

install_package "OBS Studio" "paru -S --noconfirm obs-studio" ""

install_package "Zathura" "paru -S --noconfirm zathura zathura-pdf-poppler" "xdg-mime default org.pwmt.zathura.desktop application/pdf"

print_blue "Installing display manager"

install_package "sddm" "sudo pacman -S --noconfirm sddm" "
  sudo systemctl enable sddm;
  paru -Sy --noconfirm sddm-sugar-dark;
  sudo sed -i 's/Current=/Current=sugar-dark/' /usr/lib/sddm/sddm.conf.d/default.conf
"

# END Install required packages

print_green "Installation are finished"
print_gray "------------------------------------"
echo ""
print_blue "If you are in asus laptop see: https://asus-linux.org/wiki/arch-guide/"
echo ""
print_blue "For install tmux plugins enter a tmux session and press CTRL+b and shift+i"
echo ""
print_blue "For install latex: https://tug.org/texlive/quickinstall.html"
print_blue "I recommend follow this instrutions for install kvm: https://gist.github.com/tatumroaquin/c6464e1ccaef40fd098a4f31db61ab22"
print_blue "and install for network management virt-manager: 'paru -Sy --noconfirm dnsmasq'"
print_blue "If you selected android studio and you have btrfs system: "
print_blue "\$  echo \"QuickbootFileBacked = off\" >> ~/.android/advancedFeatures.ini"
print_blue "more info on https://www.reddit.com/r/btrfs/comments/l8qu3l/android_emulator_is_unusable_on_btrfs_partition/"

#TODO:
# add virtualBox
# add VirtualManager if its possible
