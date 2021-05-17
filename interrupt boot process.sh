#-INTERRUPT BOOT PROCESS TO ACCESS TO THE SYSTEM-#
Start or reboot system
Stop Grub autoselection
Ensure the appropriate kernel is highlighted and press E to edit
Navigate to the linux16 line, press E
Add line rd.break
CTRL+X
System boots into emergency mode
Mount /sysroot with read and write permissions
»» mount -oremount, rw /sysroot
Switch into chroot jail:
»» chroot /sysroot
Reset root password
Clean up
»» touch /.autorelabel
exit