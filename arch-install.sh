#!/bin/bash
# To-Do List Post Install
# passwd
# passwd darren
# EDITOR=nano visudo
# https://manual.siduction.org/sys-admin-btrfs-snapper_en.html

yay -S --noconfirm  auto-cpufreq  update-grub plasma6-applets-thermal-monitor-git  czkawka-gui-bin zenpower3-dkms  nvm mkinitcpio-firmware  linux-ck  linux-ck-headers linux-firmware amd-ucode bibata-cursor-theme-bin  numix-circle-icon-theme-git  pyenv-virtualenv  7-zip  hplip-plugin  etcher-bin compiz xorgxrdp-glamor   vulkan-amdgpu-pro  linux-amd-znver3  linux-amd-znver3-headers zenergy-dkms-git  amdctl-git  amdgpu_top-bin  amdmond-bin 
&& 
sudo pacman -S --noconfirm fwupd packagekit ntfs-3g dosfstools  xfsprogs btrfs-progs snapper grub efibootmgr xdg-user-dirs-gtk  networkmanager mtools pacman-contrib plank ccache haveged ufw bluez bluez-utils alsa-utils spectacle krunner partitionmanager kcalc kwrite ark dolphin konsole packagekit-qt5 hplip cups go os-prober libreoffice-fresh thunderbird openssh dhcpcd acpi cpio ffmpeg ffmpegthumbnailers xf86-video-amdgpu 

pacman -Syu archlinux-keyring pacman-contrib --noconfirm
mkfs.vfat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.xfs /dev/sda3 -f
mount /dev/sda3 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
pacstrap /mnt base base-devel linux linux-headers linux-firmware amd-ucode archlinux-keyring sudo nano  --noconfirm
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
arch-chroot /mnt hwclock --systohc
arch-chroot /mnt echo "en_US.UTF-8 UTF-8" >> /mnt/etc/locale.gen && echo "en_US ISO-8859-1" >> /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
arch-chroot /mnt hwclock --systohc
arch-chroot /mnt pacman -Sy --needed --noconfirm xorg sddm plasma kde-applications git curl wget zsh fwupd packagekit ntfs-3g dosfstools firefox xfsprogs btrfs-progs snapper grub efibootmgr networkmanager mtools pacman-contrib plank ccache haveged ufw bluez bluez-utils alsa-utils spectacle krunner partitionmanager kcalc kwrite ark dolphin konsole packagekit-qt5 hplip cups go os-prober libreoffice-fresh thunderbird openssh dhcpcd acpi cpio ffmpeg ffmpegthumbnailers xf86-video-amdgpu  kvantum-qt5 fzf neofetch xdg-user-dirs-gtk qbittorrent 
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf
arch-chroot /mnt export LANG="en_US.UTF-8"
echo "archduke" > /mnt/etc/hostname
cat > /mnt/etc/hosts <<HOSTS
127.0.0.1      localhost
::1            localhost
127.0.1.1      archduke
HOSTS

arch-chroot /mnt useradd -m -G wheel darren
arch-chroot /mnt mkinitcpio -P && grub-install --target=x86_64-efi --bootloader-id=archduke && grub-mkconfig -o /boot/grub/grub.cfg
arch-chroot /mnt systemctl enable NetworkManager && systemctl enable haveged && systemctl enable ufw && systemctl enable bluetooth && systemctl enable cups && systemctl enable fstrim.timer && systemctl enable sddm && systemctl enable dhcpcd
