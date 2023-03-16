#!/bin/bash

: '
    Author:         n4t5u
    Email:          hello@nasru.me
    Version:        1.1
    Created:        15/11/2022
    Modified:       16/03/2023
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
    ./strap.sh > /dev/null 2>&1
    echo "$red BlackArch keyrings are being updated and the system is being updated."

    # Updating the system
    pacman -Syu --noconfirm > /dev/null 2>&1

    # Install required packages
    echo "$red Required Packages are being installed"
    pacman -S --noconfirm terminator go python3 python-pip burpsuite gobuster dirb nmap airoscript john hashcat sqlmap hydra htop snapd > /dev/null 2>&1
    echo "$green All packages installed"

    # Snap requirements
    systemctl enable --now snapd.socket
    systemctl restart snapd.socket
    ln -s /var/lib/snapd/snap /snap

    # Install Snap Packages
    echo "$red Snap Packages are being installed"
    snap install spotify notion-snap vlc postman telegram-desktop discord slack > /dev/null 2>&1
    snap install code --classic > /dev/null 2>&1
    echo "$green Snap Packages has been installed"

    # Cleaning the downloaded files
    rm -rf strap.sh

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