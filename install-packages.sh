#! /usr/bin/bash

# Update all packages
sudo pacman -Syu
sudo steamos-readyonly disable

read -p "Do you want to install the base packages? Press Enter or type 'y' to proceed, or 'n' to skip: " base_packages
if [[ -z "$base_packages" || "$base_packages" == "y" ]]
then

    # "remove" gnupg
    sudo mv /etc/gnupg /etc/gnupg2

    # Init keyring
    sudo pacman-key --init
    sudo pacman-key --populate archlinux

    # "Remove" fakeroot to install base-devels
    sudo mv /etc/ld.so.conf.d/fakeroot.conf /etc/ld.so.conf.d/fakeroot2.conf
    sudo pacman -S base-devel
else
    echo "Base Packages were not installed"
    sudo steamos-readyonly enable
fi

installDocker() {
    sudo pacman -S docker
    sudo pacman -S docker-compose
}

installNetstat() {
    sudo pacman -S net-tools
}

installRatbagd() {
    sudo pacman -S ratbagd
}
installPython() {
    sudo pacman -S python
    sudo pacman -S python-pip
}

# Install pacman packages
installMorePackages() {
    echo
    read -p "Install docker? Press Enter or type 'y' to proceed, or 'n' to skip: " install_docker
    case "$install_docker" in
        [yY] | "" ) installDocker;;
        [nN] ) echo "Docker was not installed";;
        * ) echo "Invalid input. Docker was not installed";;
    esac

    echo
    read -p "Install netstat? Press Enter or type 'y' to proceed, or 'n' to skip: " install_netstat
    case "$install_netstat" in
        [yY] | "" ) installNetstat;;
        [nN] ) echo "Netstat was not installed";;
        * ) echo "Invalid input. Netstat was not installed";;
    esac

    echo
    read -p "Install ratbagd? Press Enter or type 'y' to proceed, or 'n' to skip: " install_ratbagd
    case "$install_ratbagd" in
        [yY] | "" ) installRatbagd;;
        [nN] ) echo "Ratbagd was not installed";;
        * ) echo "Invalid input. Ratbagd was not installed";;
    esac

    echo
    read -p "Install python? Press Enter or type 'y' to proceed, or 'n' to skip: " install_python
    case "$install_python" in
        [yY] | "" ) installPython;;
        [nN] ) echo "Python was not installed";;
        * ) echo "Invalid input. Python was not installed";;
    esac
    sudo steamos-readyonly enable
}

read -p "Do you want to install more packages? Press Enter or type 'y' to proceed, or 'n' to skip: " install_packages

case "$install_packages" in
    [yY] | "" ) installMorePackages;;
    [nN] ) echo "No more packages were installed";;
    * ) echo "Invalid input. No more packages were installed";;
esac
