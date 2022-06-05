#!/bin/sh

# Preinstall script
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
echo "Select en_US.UTF-8"
sleep 2
vim /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

touch /etc/hostname
echo "macbookpro" >> /etc/hostname
echo "Add hosts"
sleep 2
vim /etc/hosts

echo "Making swapfile"
sleep 2
truncate -s 0 /swapfile
chattr +C /swapfile 
dd if=/dev/zero of=/swapfile bs=1G count=2 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile none swap defaults 0 0" >> /etc/fstab

passwd
pacman -S networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools git reflector bluez bluez-utils cups xdg-utils xdg-user-dirs alsa-utils base-devel os-prober

echo "Enabling services"
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable --now cups 
echo "Done"
sleep 2

echo "Installing grub"
echo "Add kernel params and os-prober"
sleep 2
vim /etc/default/grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
echo "Done"
sleep 2

useradd -mG wheel aamod
passwd aamod
echo "visudo"
sleep 2
EDITOR=vim visudo
echo "Done. Exit and reboot and run the other script"
