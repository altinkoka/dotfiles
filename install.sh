#!/bin/bash

#
# Author: Iglinsc <igli.linux@gmail.com>
#
# This script automates the setup of my personal Arch Linux environment.
# Feel free to modify and use for your own purposes.
#
# Why do Linux users prefer command line to GUI? Because they're afraid of the mouse.
#


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

# Clone dotfiles repo and move into the directory
git clone https://github.com/altinkoka/dotfiles.git ~/Dotfiles
cd ~/Dotfiles

# Install packages from pacman and yay
echo "Installing packages from pacman..."
sudo pacman -S --noconfirm --needed - < paclist.txt

echo "Installing packages from yay..."
yay -S --noconfirm --needed - < yaylist.txt

# Copy fonts to /usr/share/fonts
echo "Copying fonts to /usr/share/fonts..."
sudo cp -r fonts/* /usr/share/fonts/

# Copy dotfiles to home directory
echo "Copying dotfiles to home directory..."
cp -r dotfiles/* ~/

# Check if NordVPN is installed, if not install it
if ! command -v nordvpn &> /dev/null; then
  echo "NordVPN not found, installing..."
  yay -S --noconfirm --needed nordvpn-bin
  sudo systemctl enable nordvpnd.service
  sudo systemctl start nordvpnd.service
  sudo gpasswd -a $USER nordvpn
else
  echo "NordVPN is already installed."
fi

# Check if TeamViewer is installed, if not install it
if ! command -v teamviewer &> /dev/null; then
  echo "TeamViewer not found, installing..."
  yay -S --noconfirm --needed teamviewer
  sudo systemctl enable teamviewerd.service
  sudo systemctl start teamviewerd.service
else
  echo "TeamViewer is already installed."
fi

# Check if VirtualBox is installed, if not install it
if ! command -v virtualbox &> /dev/null; then
  echo "VirtualBox not found, installing..."
  sudo pacman -S --noconfirm --needed virtualbox virtualbox-host-modules-arch
  sudo modprobe vboxdrv
  sudo gpasswd -a $USER vboxusers
  sudo systemctl enable vboxweb.service
  sudo systemctl start vboxweb.service
else
  echo "VirtualBox is already installed."
fi

echo "Installation complete!"

