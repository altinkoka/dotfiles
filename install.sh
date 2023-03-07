#!/bin/bash

#
# Author: Iglinsc <igli.linux@gmail.com>
#
echo "+---------------------------------------------------+"
echo "|              Arch Linux Setup Script              |"
echo "+---------------------------------------------------+"

echo "Welcome to the Arch Linux Setup Script. This script is designed to automate the installation process and save you time and effort. You have the option to choose between installing only the packages required to set up a clean system or the entire package list. Please make your selection accordingly and follow the prompts to complete the installation."

# This command will exit the script if it fails
set -e

echo "Starting dotfiles installation..."

# Check if yay is installed, if not install it
if ! command -v yay &> /dev/null; then
  echo "yay not found, installing..."
  sudo pacman -S --noconfirm --needed base-devel git
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
else
  echo "yay is already installed."
fi

# Ask the user if they want to install power management
read -p "Do you want to install power management (Recommended for laptops)? (y/n) " choice
if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
  echo "Installing and enabling power management..."
  sudo pacman -S --noconfirm --needed tlp
  sudo systemctl enable tlp.service
  sudo systemctl start tlp.service
  sudo echo CPU_SCALING_GOVERNOR_ON_AC=powersave >> /etc/tlp.conf
  sudo echo CPU_SCALING_GOVERNOR_ON_BAT=powersave >> /etc/tlp.conf
else
  echo "Skipping power management installation."
fi

# Installation command for Hyprland
echo "Installing Hyprland..."
yay -S --noconfirm --meeded hyprland

# Prompt the user to install the latest NVIDIA drivers
read -p "Do you want to install the latest NVIDIA drivers? [y/n]: " nvidia_response

if [[ "$nvidia_response" =~ ^[Yy]$ ]]; then
    # Install the latest NVIDIA drivers
    sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils
    sudo mkinitcpio -P
fi

# Prompt the user to install the latest Intel drivers
read -p "Do you want to install the latest Intel drivers? [y/n]: " intel_response

if [[ "$intel_response" =~ ^[Yy]$ ]]; then
    # Install the latest Intel drivers
    sudo pacman -S xf86-video-intel
fi


# Clone dotfiles repo and move into the directory
read -p "Have you already cloned the Dotfiles directory? (y/n) " dotfiles_choice
if [ "$dotfiles_choice" == "y" ] || [ "$dotfiles_choice" == "Y" ]; then
  echo "Moving into Dotfiles directory..."
  cd ~/Dotfiles
else
  git clone https://github.com/altinkoka/dotfiles.git ~/Dotfiles
  cd ~/Dotfiles
fi

# Prompt user for choice of apps to install
echo "Which apps do you want to install?"
echo "1 - All system apps"
echo "2 - Only apps for a clean system"
read choice

# Install the appropriate packages based on user input
if [ "$choice" == "1" ]; then
  # Install all apps
  echo "Installing all system apps..."
  sudo pacman -S --noconfirm --needed - < dotfiles/paclist.txt
  yay -S --noconfirm --needed - < dotfiles/yaylist.txt
elif [ "$choice" == "2" ]; then
  # Install only clean system apps
  echo "Installing only apps for a clean system..."
  sudo pacman -S --noconfirm --needed - < pac-clean.txt
  yay -S --noconfirm --needed - < yay-clean.txt
fi

# Copy fonts to /usr/share/fonts
echo "Copying fonts to /usr/share/fonts..."
sudo cp -r fonts/* /usr/share/fonts/

# Copy dotfiles to home directory
echo "Copying dotfiles to home directory..."
cd dotfiles/ && cp -r * ~/ 


# Prompt to install additional programs
read -p "Do you want to install Teamviewer? (Y/N) " teamviewer_choice
if [ "$teamviewer_choice" == "Y" ] || [ "$teamviewer_choice" == "y" ]; then
    if ! command -v teamviewer &> /dev/null; then
        yay -S --noconfirm teamviewer
    fi
fi

read -p "Do you want to install Virtualbox? (Y/N) " virtualbox_choice
if [ "$virtualbox_choice" == "Y" ] || [ "$virtualbox_choice" == "y" ]; then
    if ! command -v virtualbox &> /dev/null; then
        yay -S --noconfirm virtualbox
    fi
fi

read -p "Do you want to install Nordvpn? (Y/N) " nordvpn_choice
if [ "$nordvpn_choice" == "Y" ] || [ "$nordvpn_choice" == "y" ]; then
    if ! command -v nordvpn &> /dev/null; then
        yay -S --noconfirm nordvpn-bin
    fi
fi

read -p "Do you want to install Vscodium? (Y/N) " vscodium_choice
if [ "$vscodium_choice" == "Y" ] || [ "$vscodium_choice" == "y" ]; then
    if ! command -v codium &> /dev/null; then
        yay -S --noconfirm vscodium-bin
    fi
fi

read -p "Do you want to install SDDM? (Y/N) " sddm_choice
if [ "$sddm_choice" == "Y" ] || [ "$sddm_choice" == "y" ]; then
    if ! command -v sddm &> /dev/null; then
        yay -S --noconfirm sddm
        sudo systemctl enable sddm.service
    fi
fi

read -p "Do you want to install Network Manager applet? (Y/N) " npaplet_choice
if [ "$npaplet_choice" == "Y" ] || [ "$npaplet_choice" == "y" ]; then
    if ! command -v nm-applet &> /dev/null; then
        yay -S --noconfirm network-manager-applet
    fi
fi




echo "Installation complete!Enjoy!"
# Execute Hyprland command with countdown
echo "Logging in the new Desktop in 7... "
sleep 1
echo "6... "
sleep 1
echo "5... "
sleep 1
echo "4... "
sleep 1
echo "3... "
sleep 1
echo "2... "
sleep 1
echo "1... "
sleep 1

echo  "Enjoy!"
Hyprland
