# Arch Linux Installer
This is simple shell script to make easier of arch linux minimalist installation with GUI installed.

```
Note: This only work with pc or laptop that are support uefi boot
```

# How to run the script
Before run the script I recommend you to make partition using partitioning software. Here's list of essential partition :

* uefi boot (fat32)
* linux system (ext4)
* swap partition (swap)

## Running the script
1. First boot to arch linux live usb

2. After boot successfully. Check the wireless network with typing
   ```
   ip link
   ```
   Note : every devices have different wireless card 

3. Connect to Network
   ```
   iwd
   ```
   After entering iwd type 
   ```
   station <wireless codename> scan
   ```
   After scan the available network type
   ```
   station <wireless codename> connect <you're network name>
   ```
   After that type
   ```
   ping google.com
   ```
   to check if you're network has connected
4. Install git to arch linux live usb
   ```
   pacman -Sy git
   ```
5. Clone arch linux installer file to arch live usb
   ```
   git clone https://github.com/JustLittleCode150/ArchInstaller.git
   ```
6. After done. Run arch installer script
   ```
   ./ArchInstaller/install-step1.sh
   ```
7. After done with first script run second script type
   ```
   ./ArchInstaller/install-step2.sh
   ```
   wait until install operation finish
8. After installation finish, type
   ```
   exit
   ```
9. unmount all partition, type
   ```
   umount -R /mnt  
   ```
10. now reboot the system
    ```
    reboot now
    ```


 




