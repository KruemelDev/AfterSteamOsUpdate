#! /usr/bin/bash

# Update all packages
sudo steamos-readonly disable

# "remove" gnupg
sudo rm -rf /etc/pacman.d/gnupg

# Init keyring

sudo pacman-key --init
sudo pacman-key --populate

sudo pacman -Syu

read -p "Do you want to install the base packages? Press Enter or type 'y' to proceed, or 'n' to skip: " base_packages
if [[ -z "$base_packages" || "$base_packages" == "y" ]]
then

    # "Remove" fakeroot to install base-devels
    sudo mv /etc/ld.so.conf.d/fakeroot.conf /etc/ld.so.conf.d/fakeroot2.conf
    sudo pacman -S base-devel

else
    echo "Base Packages were not installed"
fi

installDocker() {
    sudo pacman -S docker -y
    sudo pacman -S docker-compose -y
    sudo pacman -S docker-buildx -y
}

installNetstat() {
    sudo pacman -S net-tools -y
}

installRatbagd() {
    sudo pacman -S ratbagd -y
}
installPython() {
    sudo pacman -S python -y
    sudo pacman -S python-pip -y
}
installJava(){
    sudo pacman -S jdk17-openjdk openjdk17-doc -y
    sudo pacman -S openjdk17-src -y
    sudo pacman -S jre17-openjdk -y
}
installNode(){
    sudo pacman -S nodejs -y
}
installGlibc(){
    sudo pacman -S glibc -y
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
        [nN] ) echo "python was not installed";;
        * ) echo "Invalid input. python was not installed";;
    esac
    echo
    read -p "Install node? Press Enter or type 'y' to proceed, or 'n' to skip: " install_node
    case "$install_node" in
        [yY] | "" ) installNode;;
        [nN] ) echo "node was not installed";;
        * ) echo "Invalid input. node was not installed";;
    esac
    echo
    read -p "Install java? Press Enter or type 'y' to proceed, or 'n' to skip: " install_java
    case "$install_java" in
        [yY] | "" ) installJava;;
        [nN] ) echo "java was not installed";;
        * ) echo "Invalid input. java was not installed";;
    esac
    echo
    read -p "Install glibc? Press Enter or type 'y' to proceed, or 'n' to skip: " installGlibc
    case "$install_java" in
        [yY] | "" ) installGlibc;;
        [nN] ) echo "glibc was not installed";;
        * ) echo "Invalid input. glibc was not installed";;
    esac
}

read -p "Do you want to install more packages? Press Enter or type 'y' to proceed, or 'n' to skip: " install_packages

case "$install_packages" in
    [yY] | "" ) installMorePackages;;
    [nN] ) echo "No more packages were installed";;
    * ) echo "Invalid input. No more packages were installed";;
esac
