#!/bin/bash

: '
    Author:         n4t5u
    Email:          hello@nasru.me
    Version:        1.3
    Created:        15/11/2022
    Modified:       12/09/2023
    ScriptName:     PersonalArchSetup
    Description:    Automated the steps taken to install and setup my arch setup
    How To:         Run the script as Root
'

# Colour output definitions
red=$( tput setaf 1 );
yellow=$( tput setaf 3 );
green=$( tput setaf 2 );
normal=$( tput sgr 0 );

# Main function
function main() {

# Downloading Blackarch Repository
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
echo "$red BlackArch keyrings will be installed and the system will be updated."
./strap.sh > /dev/null 2>&1

# Updating the system
pacman -Syu --noconfirm > /dev/null 2>&1

echo "$red Specified Packages will be installed now"

# Required Network Purpose tools
pacman -S --noconfirm openbsd-netcat whois drill traceroute samba openssl > /dev/null 2>&1

# Required Programming Languages and General tools
pacman -S --noconfirm terminator vlc telegram go python3 python-pip nim > /dev/null 2>&1

# Security tools
pacman -S --noconfirm burpsuite gobuster ffuf dirb nmap airoscript john hashcat sqlmap hydra smbmap metasploit wireshark-qt wireshark-cli > /dev/null 2>&1

echo "$green All specified packages installed Successfully."

# Snap requirements
systemctl enable --now snapd.socket
systemctl restart snapd.socket
ln -s /var/lib/snapd/snap /snap

# Install Snap Packages
echo "$red Snap Packages will be installed now."
snap install spotify postman discord slack > /dev/null 2>&1
snap install code --classic > /dev/null 2>&1
echo "$green All packages from SnapCraft has been installed Successfully."

# Cleaning the downloaded files
rm -rf strap.sh

# Adds custom Aliases to ZSH
cat <<EOF >> ~/.zshrc 
# Custom Aliases
alias ll='ls -al'
alias cls=clear
alias pacdate='sudo pacman -Syyu'
alias paci='sudo pacman -S'
alias pacd='sudo pacman -R'
EOF

# Rebooting the system
echo "$yellow Your system will reboot in 10 Seconds. If you do not want to press CTRL + C to cancel"
sleep 10
reboot now
}

#Checks for sudo access before running the main function
if [[ ${UID} == 0 ]]; then
    main

    exit 1
else
    echo "${red}
    This script needs SUDO access......
    Please run using sudo.${normal}
    "
    exit 1
fi