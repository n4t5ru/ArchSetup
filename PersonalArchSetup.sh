#!/bin/bash

: '
    Author:         n4t5u
    Email:          hello@nasru.me
    Version:        1.0
    Created:        15/11/2022
    ScriptName:     PersonalArchSetup
    Description:    Automated the steps taken to install and setup my arch setup
    How To:         Run the script as Root
'

# Colour output definitions
red=$( tput setaf 1 );
yellow=$( tput setaf 3 );
green=$( tput setaf 2 );
normal=$( tput sgr 0 );

Supressor=$(> /dev/null 2>&1);

# Main function
function main() {
    # Blackarch Repository installation
    curl -O https://blackarch.org/strap.sh
    chmod +x strap.sh
    ./strap.sh
    echo "$yellow BlackArch keyrings are being updated and the system is being updated."
    pacman -Syu --noconfirm $Supressor
    
    # Install BlackArch tools
    echo "$green Required Packages are being installed"
    pacman -S blackarch-webapp blackarch-scanner blackarch-forensic blackarch-crypto blackarch-cracker blackarch-exploitation

    # Install required packages
    echo "$green Required Packages are being installed"
    pacman -S --noconfirm terminator go python3 python-pip burpsuite gobuster dirb nmap airoscript john hashcat sqlmap hydra htop snapd $Supressor

    # Install Snap Packages
    echo "$green Snap Packages are being installed"
    snap install spotify notion-snap vlc postman telegram-desktop lxd discord $Supressor
    snap install code --classic $Supressor

    # Cleaning the downloaded files
    rm -rf strap.sh snapd
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