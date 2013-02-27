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

 
vmadm boot $UUID order=cd,once=d cdrom=$CDROM,cdrom=$TOOLS 

vmadm info $UUID vnc

echo "Now connect with VNC."
echo "at the install prompt, type the following:"
echo "auto url=https://github.com/elijah/smartos-debian-preseed/debian-stable-x86.cfg/raw"

# 
# <derek@joyent.com> to clean that up you have to "zonecfg -z c5141ac5-7765-41f7-b441-434149b61b7c delete -F" and then "zfs destroy -r zones/c5141ac5-7765-41f7-b441-434149b61b7c" 
 
