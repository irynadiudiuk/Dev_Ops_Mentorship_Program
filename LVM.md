

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
 -There are two ways to create LVM partitions. The first one is using disk management command, for example, ```fdisk``` to create a primary partition and then choose ```8e``` option to specify Linux LVM partition type. This will create a new proimary partition with partition table and the type of this partitions will be Linux LVM. Below is the screenshot of the list of possible partition types in Ubuntu 16.04
 ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/LVM/8E.PNG)
 
The second way is to create an LVM partition wihthout a partition table. To do this is add a new hard drive and type ```pvcreate /dev/sd*```. Below is the screenshot showing the uotput of the command ```lsblk```, where two LVM partitions are displayed.
sdd1 - with a parittion table and and sdc without
 ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/LVM/withwithout.PNG)
 
 ***Resources***
 
 1. https://unix.stackexchange.com/questions/29386/how-do-you-copy-the-public-key-to-a-ssh-server
 2. https://stackoverflow.com/questions/2841094/what-is-the-difference-between-dsa-and-rsa
 3. https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Logical_Volume_Manager_Administration/VG_remove_PV.html
 4. https://www.slideshare.net/prakashrockz/red-hat-lvm-cheatsheet
 




