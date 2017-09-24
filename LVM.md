

### **BASIC LVM Commands** ###
-------
*Topics covered:*
1. Basic Concepts;
2. LVM Commands;
2. PV as a part of partition with and without partition table;
3. Resources.


***Basic Concepts***
LVM works with three basic concepts:
1. Physical Volumes - correspond to disks; 
2. Volume Groups - named collections of physical volumes, they are block devices that provide the space to store logical volumes;
3. Logical Volumes - correspond to partitions, hold the filesystems, can span across multiple disks, and do not have to be physically contiguous.
_______________________________________________________________________________________________________________________________________

***LVM Commands***
_______________________________________________________________________________________________________________________________________

In case of installation of LVM to a new system
1. choose option “Use LVM with new Ubuntu installation” 
2. “File Sytem Type: physical volume (LVM)” on Centos 
*/boot partition cannot reside on an LVM volume because the GRUB boot loader cannot read it.
______________________________________________________________________________________________________________________________________
lvmdiskscan -l -  to see info in LVM devices in the system ![Screenshot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/LVM/lvm.PNG)


pvcreate /dev/sd* -  to create physical volume
vgcreate vg1 /dev/sd* - to create volume group with the name vg1
pvscan/vgscan/lvscan - to see information on physical volumes, volume groups or logical volumes correspondently (can be used in form on pvs,vgs/lvs)

![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/LVM/vgs.PNG)


lvcreate -L+3G -n lv1 vg1to create a logical volume name lv1 using vg1
mkfs -t ext* /dev/vg1/lv1m - to format new lv with a file system
mkdir /mnt/lv  - to create a mount point
mount /dev/vg1/lv1 /mnt/lv1m - to mount
vgextend vg1 /dev/sd* - to extend vg with newly added hard drive
lvextend -L8G /dev/vg1/lv1 - to extend to up to a 8G
lvextend -L+3G /dev/vg1/lv1 - to add 3G
resize2fs /dev/vg1/lv1 - to resize lv (before that e2fck -f /dev/vg*/lv/* needs to be run)
lvextend -L-0.65Gib /dev/vg1/lv1 - to reduce 0.65Gib
lvcreate -L512M -s -n lvstuffbackup /dev/vgpool/lvstuff - to create a snapshot
mkdir /mnt/lv1backup
mount /dev/vg1/lv1backup /mnt/lv1backup - to mount this snapshot
tar -cf /home/rothgar/Backup/lv1-ss /mnt/lv1backup/ - to archive the snapshot
umount /mnt/lv1backup
lvremove /dev/vg1/lv1backup/ - to unmount and remove the snapshot
umount /mnt/lv1
lvremove /dev/vg1/lv1
vgremove vg1
pvremove /dev/sd* /dev/sd* - unmount and remove all

 
 ***PV as a part of partition with and without partition table*** 
 -New hard drive added and fdisk utility used  (t - to change partition type / 8e - to change to LVM partition type)
 
 As a result we have used two ways of creating ssh key pairs, used key-based authentication to connect to remote machines, created key pairs with passphrase, added keys to ssh agent and used ssh forwaring to connect to remote machines without entering the passphrase.
 
 
 ***Resources***
 
 1. https://unix.stackexchange.com/questions/29386/how-do-you-copy-the-public-key-to-a-ssh-server
 2. https://stackoverflow.com/questions/2841094/what-is-the-difference-between-dsa-and-rsa
 3. https://github.com/irynadiudiuk/Linux_Fundamentals/edit/master/SSH_Keys_Set_Up/SSH_Keys_Set_Up.md
 4. https://www.youtube.com/watch?v=CVbOHZty7j0
 




