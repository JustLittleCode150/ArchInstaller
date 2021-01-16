#!/bin/bash

# simple installer for arch linux with gnome desktop 

# get user partition info
echo "Install option : "
echo "1.format new uefi partition"
echo -e "2.keep uefi partition \n"

echo -e "Do you want to : \c"
read -r OPTION
echo -e "\n"

if [ $OPTION -eq '1' ]
then
    echo -e "which uefi partition(/dev/sda)? \c"
    read -r BOOT_TYPE

    echo -e "which system partition(/dev/sda)? \c"
    read -r SYSTEM_PATH

    echo -e "which swap parition(/dev/sda)? \c"
    read -r SWAP_PATH

    echo -e "This operation can be undone, do you want to continue(y/n)? \c"
    read -r FINAL

    if [ $FINAL == "y" ]
    then
        # format created partition 
        mkfs.vfat -F 32 $BOOT_TYPE
        yes y | mkfs.ext4 $SYSTEM_PATH
        mkswap $SWAP_PATH
    elif [ $FINAL == "n" ]
    then
        echo "operation cancelled"
        exit 1
    fi

elif [ $OPTION -eq '2' ]
then
    echo -e "which system partition(/dev/sda)? \c"
    read -r SYSTEM_PATH

    echo -e "which swap parition(/dev/sda)? \c"
    read -r SWAP_PATH

    echo -e "This operation can be undone, do you want to continue(y/n)? \c"
    read -r FINAL

    if [ $FINAL == "y" ]
    then
        # format created partition
        yes y | mkfs.ext4 $SYSTEM_PATH
        mkswap $SWAP_PATH
    elif [ $FINAL == "n" ]
    then
        echo "operation cancelled"
        exit 1
    fi
fi

# mounting partition
mount $SYSTEM_PATH /mnt 
swapon $SWAP_PATH 

# installing dependencies
echo "Desktop environment:"
echo "1.gnome"
echo "2.xcfe"
echo -e "3.kde\n"

echo -e "choose you're desktop environment(1,2)? \c"
read -r DESKTOP

if [ $DESKTOP -eq '1' ]
then
    echo -ne '\n \n \n \n \n \n \n \n' | ./ArchInstaller/Desktop/gnome.sh
elif [ $DESKTOP -eq '2' ]
then
    echo -ne '\n \n \n \n \n \n \n' | ./ArchInstaller/Desktop/xcfe.sh
elif [ $DESKTOP -eq '3' ]
then
    echo -ne '\n \n \n \n \n \n \n \n \n' | ./ArchInstaller/Desktop/kde.sh
fi

# generate fstab info to arch linux
genfstab -U -p /mnt >> /mnt/etc/fstab

# move next post installer to root partition
cp -R ./ArchInstaller/ /mnt

# change root
arch-chroot /mnt
