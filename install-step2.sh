#!/bin/bash

# some variable
echo -e "which uefi partition(/dev/sda) \c?"
read -r UEFI_PARTITION

echo -e "which region are you live(/continent/city) \c?"
read -r REGION

echo -e "Type you hostname? \c"
read -r HOSTNAME

echo -e "Type you username? \c"
read -r USERNAME

echo "Desktop environment:"
echo "1.gnome"
echo "2.xcfe"
echo -ne "3.kde\n"

echo -e "choose you're desktop environment(1,2,3)? \c"
read -r DESKTOP

# setup keyboard layout 
sed -i "/^#en_US.UTF-8 UTF-8/ cen_US.UTF-8 UTF-8" /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# setup time date and region 
ln -sf /usr/share/zoneinfo$REGION /etc/localtime
hwclock --systohc --utc

# setup localhost 
echo $HOSTNAME > /etc/hostname
cat << 'EOF' >> /etc/hosts 
127.0.1.1 localhost.localdomain arch
::        localhost.localdomain arch
EOF

# install and setup grub bootloader
mkdir /boot/efi
mount $UEFI_PARTITION /boot/efi
grub-install --target=x86_64-efi --bootloader-id=Arch --efi-directory=/boot/efi
yes y | pacman -Rs linux
os-prober
grub-mkconfig -o /boot/grub/grub.cfg

# set root password
echo "set root password"
passwd

# adduser and set password to new user 
useradd -m -g users -G wheel -s /bin/bash $USERNAME
echo "set new username password"
passwd $USERNAME

# give all user root access
sed -i "/^# %wheel ALL=(ALL) ALL/ c%wheel ALL=(ALL) ALL" /etc/sudoers

# enable sysrq
echo "1" >/proc/sys/kernel/sysrq
echo "kernel.sysrq = 1" >> /etc/sysctl.d/99-sysctl.conf

# installing yay
curl -O https://arch.alerque.com/x86_64/yay-10.1.2-1-x86_64.pkg.tar.zst
yes y | pacman -U yay-10.1.2-1-x86_64.pkg.tar.zst
rm yay-10.1.2-1-x86_64.pkg.tar.zst

if [ $DESKTOP -eq '1' ]
then
    # setup some runtime
    yes y | pacman -Sy dialog dhcpcd wpa_supplicant networkmanager iwd bluez bluez-utils gnome-bluetooth gnome-control-center ttf-hanazono ttf-baekmuk
    systemctl stop dchcpcd
    systemctl disable dhcpcd
    systemctl start wpa_supplicant
    systemctl enable wpa_supplicant
    systemctl start NetworkManager
    systemctl enable NetworkManager 
    systemctl start iwd
    systemctl enable iwd
    systemctl start cups
    systemctl enable cups
    systemctl start bluetooth
    systemctl enable bluetooth

    # enable display manager
    systemctl start gdm
    systemctl enable gdm

elif [ $DESKTOP -eq '2' ]
then
    # setup some runtime
    yes y | pacman -Sy dialog dhcpcd wpa_supplicant networkmanager iwd bluez bluez-utils ttf-hanazono ttf-baekmuk
    systemctl stop dchcpcd
    systemctl disable dhcpcd
    systemctl start wpa_supplicant
    systemctl enable wpa_supplicant
    systemctl start NetworkManager
    systemctl enable NetworkManager 
    systemctl start iwd
    systemctl enable iwd
    systemctl start cups
    systemctl enable cups
    systemctl start bluetooth
    systemctl enable bluetooth

    # enable display manager
    systemctl start lightdm
    systemctl enable lightdm

elif [ $DESKTOP -eq '3' ]
then
    # setup some runtime
    yes y | pacman -Sy dialog dhcpcd wpa_supplicant networkmanager iwd bluez bluez-utils 
    systemctl stop dchcpcd
    systemctl disable dhcpcd
    systemctl start wpa_supplicant
    systemctl enable wpa_supplicant
    systemctl start NetworkManager
    systemctl enable NetworkManager 
    systemctl start iwd
    systemctl enable iwd
    systemctl start cups
    systemctl enable cups
    systemctl start bluetooth
    systemctl enable bluetooth

    # enable display manager
    systemctl start sddm
    systemctl enable sddm
fi

# all installation finish message 
echo  " ____________   ___   ____      ____   ___      _____________   _______        _______ "  
echo  "|            | |___| |    \    |    | |___|    |             | |       |      |       |"
echo  "|   _________|  ___  |     \   |    |  ___     |             | |       |      |       |"
echo  "|  |_________  |   | |      \  |    | |   |    |   __________| |       |      |       |"
echo  "|            | |   | |       \ |    | |   |   (           )    |       |______|       |"
echo  "|   _________| |   | |        \|    | |   |   (           )    |                      |"
echo  "|  |           |   | |    |\        | |   |  _(______     )    |        ______        |"
echo  "|  |           |   | |    | \       | |   | |             |    |       |      |       |"
echo  "|  |           |   | |    |  \      | |   | |             |    |       |      |       |" 
echo  "|__|           |___| |____|   \_____| |___| |_____________|    |_______|      |_______|"

# delete arch installer file from root partition 
rm -rf ./ArchInstaller
