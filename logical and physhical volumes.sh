#-CREATE AND REMOVE PHYSICAL AND LOGICAL VOLUMES-#
pvcreate #Create physical volume
pvdisplay #Show available physical volumes
vgcreate name /dev/DISKS #Create volume group
vgdisplay #Show available volume groups
lvcreate #Create logical volume
    -n • Volume
    -L • Size in bytes
lvremove /dev/vg/VOLUME #Remove volume
pvremove /dev/DISK #Remove physical volume
#----->CONFIGURING SYSTEM TO MOUNT FILE SYSTEM AT BOOT
mkfs -t xfs /dev/xvdf1 #Make file system
blkid #List available block devices on system
lsblk #List all attached block devices
mount /dev/disk /mnt/mountlocation #Non-persistent mount
    -Mounting with the UUID ensures the appropriate mount is used
    -Add to /etc/fstab to mount persistently
tune2fs -L LABELMNAME /dev/disk #Mount with file system label (ext)
e2label /dev/disk LABELNAME #Mount with file system label (ext)
xfs_admin -L LABELNAME /dev/disk #Mount with file system label (XFS)
mount LABEL=LABELNAME /mnt/mountlocation defaults 1 1 #Mount with label, non-persistent; edit /etc/fstab for persistence
mount -a #Mount all file systems in /etc/fstab
umount -a #Unmount all file systems in /etc/fstab

#-LOGICAL VOLUME MANAGER-#
yum install lvm2 #install LVM if not installed
pvcreate /dev/disk /dev/disk [disk-amount] #Create LVM physical volumes
pvdisplay #display all available physical volumes
vgcreate VGNAME /dev/disk /dev/disk #create a volume group. VGNAME is the name you assign to the volume group
vgdisplay #display all the available volume groups
lvcreate -n NameOfLVMVolume -L 20G VolumeGroupToUse #Create a logical volume:
    -L #size of the volume in bytes (use 1M, 1G, 20G, etc.)
    -l #size in physical extents; generally a physical extent is 4MiB in size
lvdisplay #Display view logical volumes:

#--->EXTENDING VOLUME GROUPS AND LOGICAL VOLUMES
1- Extend a volume group with a new disk:
    - pvcreate /dev/newdisk
    - vgextend vg-name /dev/newdisk
    - vgdisplay
2.1- Extend the LVM to be exactly XGBs in size:
    - lvextend -L XG /dev/vg-name/lvmname
2.2- Extend the LVM and add an additional 5G:
    - lvextend -L +5G /dev/vg-name/lvmname

#---> REMOVING LOGICAL AND PHYSICAL VOLUMES & VOLUME GROUPS
lvremove /dev/vg-name/volume #remove a logical volume
vggremove vg-name #Remove a volume group