#!/usr/bin/bash

# https://download.joyent.com/pub/vmtools/sdc-vm-tools-20111122163531.iso
# https://download.joyent.com/pub/vmtools/sdc-vm-tools-20111122163531.tar.gz

# http://cdimage.debian.org/debian-cd/6.0.7/i386/iso-cd/debian-6.0.7-i386-netinst.iso
# http://cdimage.debian.org/debian-cd/6.0.7/ia64/iso-cd/debian-6.0.7-ia64-netinst.iso

UUID=`create-machine -f debian-stable-x86.json | grep uuid | /opt/custom/bin/jsontool -aH uuid `

CDROM="debian-6.0.7-i386-netinst.iso"
TOOLS="sdc-vm-tools-20111122163531.iso"

curl -k https://github.com/elijah/smartos-debian-preseed/debian-stable-x86.cfg/raw > debian-stable-x86.cfg

# TODO - we ought to be putting the preseed file into our .iso of the OS, so that it can boot and install totally unattended.
#        For now, though, we'll suffer through using vnc to intercept GRUB / syslinux and start the install.

# OK, so looking at the files on a debian ISO, here's what we have to do:
# 1) download the iso
# 2) loopback mount it
# 3) inject the preseed file into the ROOT (/) of the ISO
# 4) update $ROOT/isolinux/txt.cfg so that we have the right boot arguments to use preseed with the installer.
# 4b) Those arguments look like this:
#     default vmlinuz
#     append preseed/file=/hd-media/preseed.cfg locale=en_US console-keymaps-at/keymap=us languagechooser/language-name=English countrychooser/shortlist=US vga=normal initrd=initrd.gz  --
#
#     Whereas a default txt.cfg looks like this:
#
#     default install
#     label install
#	menu label ^Install
#	menu default
#	kernel /install.386/vmlinuz
#	append vga=788 initrd=/install.386/initrd.gz -- quiet 
#
#
#


 
vmadm boot $UUID order=cd,once=d cdrom=$CDROM,cdrom=$TOOLS 

vmadm info $UUID vnc

echo "Now connect with VNC."
echo "at the install prompt, type the following:"
echo "auto url=https://github.com/elijah/smartos-debian-preseed/debian-stable-x86.cfg/raw"

# 
# <derek@joyent.com> to clean that up you have to "zonecfg -z c5141ac5-7765-41f7-b441-434149b61b7c delete -F" and then "zfs destroy -r zones/c5141ac5-7765-41f7-b441-434149b61b7c" 
 
