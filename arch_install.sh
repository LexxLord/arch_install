#!/bin/bash
# -*- coding: utf-8 -*-
# cSpell:disable

pacman -Sy msedit fzf bat

lsblk

cfdisk /dev/nvme0n1

mkfs.vfat -F 32 -n "BOOT" /dev/nvme0n1p1

mkswap -L "SWAP" /dev/nvme0n1p2
swapon /dev/nvme0n1p2

mkfs.ext4 -L "ROOT" -m 1 /dev/nvme0n1p3

mount /dev/nvme0n1p3 /mnt

mount --mkdir /dev/nvme0n1p1 /mnt/boot

###############################################################################
# pacman -Sy reflector
# reflector --verbose --latest 5 --age 6 --number 10 --sort rate --save /etc/pacman.d/mirrorlist
###############################################################################

pacstrap -K /mnt base base-devel linux-firmware linux-zen linux-zen-headers intel-ucode iucode-tool sudo grub efibootmgr bash-completion sof-firmware msedit fzf bat

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

hostnamectl set-hostname "SENTINEL"

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg

pacman -Syu git wget samba avahi smbnetfs openssh sshs ntp btop nano mc os-prober superfile networkmanager fastfetch

systemctl enable NetworkManager sshd

# раскомментировать %wheel ALL=(ALL:ALL) ALL
EDITOR=msedit visudo

passwd

useradd -m -g users -G wheel -s /bin/bash lexx
passwd lexx

sed -i 's/#ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen

echo -e "#LANG=en_US.UTF-8\nLANG=ru_RU.UTF-8" > /etc/locale.conf

echo -e "KEYMAP=ru\nFONT=cyr-sun16" > /etc/vconsole.conf

locale-gen

loadkeys ru

setfont cyr-sun16

export LANG=ru_RU.UTF-8

timedatectl set-timezone "$(tzselect)"

timedatectl set-ntp true

timedatectl



exit
# umount -R /mnt
# reboot



# sudo pacman -S go npm cargo python cmake clang

# sudo pacman -S ttf-liberation ttf-dejavu ttf-roboto terminus-font ttf-jetbrains-mono ttf-fira-code ttf-hack adobe-source-code-pro-fonts
# sudo pacman -S p7zip ouch xplr eza yazi broot ncdu gdu diskus duf caligula tailspin nvme-cli s-tui dua-cli lnav gpart dysk yq jq

# sudo pacman -S cifs-utils nilfs-utils ntfs-3g btrfs-progs f2fs-tools sshfs dosfstools jfsutils exfatprogs xfsdump xfsprogs mtools
# sudo pacman -S gvfs-smb gvfs-nfs gvfs-afc gvfs-goa gvfs-gphoto2 gvfs-mtp gvfs-dnssd gvfs-onedrive gvfs-wsdd gvfs

# sudo pacman -S neovim glow orbiton chafa viu mpv yt-dlp ffmpeg sox fbida wiremix imagemagick kew espeak-ng rhvoice countryfetch onefetch cpufetch

# sudo pacman -S hexyl hex hexedit hexer hexpatch binsider heh

# sudo pacman -S git-delta lazygit net-tools iwd nload aria2 git-lfs github-cli transmission-cli impala bluetui openbsd-netcat
# sudo pacman -S bmon chawan cloudflare-speed-cli speedtest-cli croc himalaya monolith netscanner termshark termscp trippy netwatch mailutils axel

# sudo pacman -S sqlite visidata television nvtop atop iftop wavemon pv tmux zellij ripgrep ripgrep-all repgrep zoxide trash-cli navi
# sudo pacman -S pastel yank gpg-tui asciinema serpl intel-ucode iucode-tool dialog ccache sccache numlockx procs hyperfine at
# sudo pacman -S pwgen age gdb cgdb cotp ctop hazelnut kmon systemctl-tui systeroid lazydocker rsync pacman-contrib
# sudo pacman -S pandoc-cli translate-shell aspell cloc difftastic diff-pdf shellcheck csvlens doxx pdfgrep tabiew treemd xan



# sudo pacman -S plymouth

# /etc/mkinitcpio.conf
# {
#     HOOKS=(... plymouth)
# }

# sudo mkinitcpio -P



# sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
# systemctl enable lightdm



# sudo pacman -S xfce4 xfce4-goodies xfce4-dev-tools xfce4-docklike-plugin xfce4-panel-profiles network-manager-applet



# GitHub ( https://tui.tools )
# curl -fsSL https://pkgs.tui.tools/install.sh | sh
# pacman -S tui-tools-all



# AUR
# xfce4-datetime-plugin zentile

# pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
# pacman-key --lsign-key 3056513887B78AEB
# pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-'{keyring,mirrorlist}'.pkg.tar.zst' --noconfirm

# echo -e "[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf

# pacman -S yay

# yay -S xfce4-sensors-plugin-nvidia xfce4-dockbarx-plugin xfce4-dxreminders-plugin

# yay -S menulibre dockbarx dxreminders mkinitcpio-firmware
