

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

In case of installation of LVM to a new system:
1. choose option “Use LVM with new Ubuntu installation” 
2. “File Sytem Type: physical volume (LVM)” on Centos 
3. */boot partition cannot reside on an LVM volume because the GRUB boot loader cannot read it.
_______________________________________________________________________________________________________________________________________


***LVM Commands***

______________________________________________________________________________________________________________________________________
```lvmdiskscan -l``` -  to see info in LVM devices in the system ![Screenshot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/LVM/lvm.PNG)


```pvcreate /dev/sd*``` -  to create physical volume

```vgcreate vg1 /dev/sd*``` - to create volume group with the name vg1

```pvscan/vgscan/lvscan``` - to see information on physical volumes, volume groups or logical volumes correspondently (can be used in form of ```pvs,vgs,lvs```)

![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/LVM/vgs.PNG)


```lvcreate -L+3G -n lv1 vg1to``` - to  create a logical volume name lv1 using vg1

```mkfs -t ext* /dev/vg1/lv1m``` - to format new lv with a file system

```mkdir /mnt/lv```  - to create a mount point

```mount /dev/vg1/lv1 /mnt/lv1m``` - to mount

```vgextend vg1 /dev/sd*``` - to extend vg with newly added hard drive

```lvextend -L8G /dev/vg1/lv1``` - to extend to up to a 8G

```lvextend -L+3G /dev/vg1/lv1``` - to add 3G

```resize2fs /dev/vg1/lv1``` - to resize lv (before that e2fck -f /dev/vg*/lv/* needs to be run)

```lvextend -L-0.65Gib /dev/vg1/lv1``` - to reduce 0.65Gib

```lvcreate -L512M -s -n lv1backup /dev/vg1/lv1``` - to create a snapshot

```lvremove /dev/vg1/lv1``` - to remove logical volume

```vgremove vg1``` - to remove volume group

```pvremove /dev/sd* /dev/sd*```  - unmount and remove more than one physical volume


________________________________________________________________________________________________________________________________
 
 ***PV as partition with and without partition table*** 
 
 There are two ways to create LVM partitions. The first one is using disk management command, for example, ```fdisk``` and create a primary partition choosing ```8e``` option to specify Linux LVM partition type.
 Below is the screenshot of the list of possible partition types in Ubuntu 16.04:
 ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/LVM/8E.PNG)
 
 
The second way is to create an LVM partition is without a partition table. To do this we add a new hard drive and type ```pvcreate /dev/sd*```. Below is the screenshot showing the output of the command ```lsblk```, where two LVM partitions are displayed.
***sdd1*** - with a parittion table and and ***sdc*** without
 ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/LVM/withwithout.PNG)
 
 Below is the table comparingtwo types of set up of LVM partition:
 
 
| Comparison Criteria | LVM with Partition Table | LVM with no Partition Table |
| :-----------:       |     :-------------:      |     :---------------------: |
| Creation of a New Volume | Additional commands need to be entered and disk management utils have to be used (e. g. fdisk, parted) to create partition table for PV.    | PV can be created straight away  |
| Extending  of Existing Volume  | Partitions can be extended since there might be some place left.   | PV cannot be extended as usually the whole disk without a partitions is used for PV     |
| Shrinking of Existing Volume   | Partitions can be reduced and the space left used for other pursopes.       |  It is not recommended to shrink PV as the space that will be left cannot be appropriately used for another PV   |
| Data Restore on External Server   | With partition table, the date about partitions contains info on what was on the disk and help in restore process       | There is no info on what was on the disk, and it often happens that disk gets overwritten with new info     |

 
 ***Resources***
 
 1. https://www.howtogeek.com/howto/40702/how-to-manage-and-use-lvm-logical-volume-management-in-ubuntu/
 2. https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/4/html/Cluster_Logical_Volume_Manager/LVM_CLI.html
 3. https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Logical_Volume_Manager_Administration/VG_remove_PV.html
 4. https://www.slideshare.net/prakashrockz/red-hat-lvm-cheatsheet
 




