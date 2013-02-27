smartos-debian-preseed
======================

Preseed files for building a Debian VM image for Joyent's SmartDataCenter product, or for a KVM instance running on SmartOS.


TODO:

We should probably inject our preseed file into a virgin ISO image so that we can make this process even more hands-off.  I don't like needing to use VNC to start the install and make it use the preseed file - that's non-ideal.

Need to update the late_command.sh script to install the sdc-vm-tools bits, as well as make other needed modifications.

Need to update the preseed .cfg file so it knows to use late_command at the end, and fire off our post-install customizations.



