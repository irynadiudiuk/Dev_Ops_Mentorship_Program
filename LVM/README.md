

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


```pvcreate /dev/sdany``` -  to create physical volume

```vgcreate vg1 /dev/sdany``` - to create volume group with the name vg1

```pvscan/vgscan/lvscan``` - to see information on physical volumes, volume groups or logical volumes correspondently (can be used in form of ```pvs,vgs,lvs```)

![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/LVM/vgs.PNG)


```lvcreate -L+3G -n lv1 vg1to``` - to  create a logical volume name lv1 using vg1

```mkfs -t ext4 /dev/vg1/lv1``` - to format new lv with a file system

```mkdir /mnt/lvmp```  - to create a mount point

```mount /dev/vg1/lv1 /mnt/lvmp``` - to mount

```vgextend vg1 /dev/sdany``` - to extend vg with newly added hard drive

```lvextend -L8G /dev/vg1/lv1``` - to extend to up to a 8G

```lvextend -L+3G /dev/vg1/lv1``` - to add 3G

```resize2fs /dev/vg1/lv1``` - to resize lv (before that e2fck -f /dev/vg*/lv/* needs to be run)

```lvextend -L-0.65Gib /dev/vg1/lv1``` - to reduce 0.65Gib

```lvcreate -L512M -s -n lv1backup /dev/vg1/lv1``` - to create a snapshot

```lvremove /dev/vg1/lv1``` - to remove logical volume

```vgremove vg1``` - to remove volume group

```pvremove /dev/sdany```  - unmount and remove more than one physical volume


________________________________________________________________________________________________________________________________
 
 ***Physical Volume as a Part of Logical Partition or as a Whole Disk*** 
 
 There are two ways to create LVM partitions. The first one is using disk management command, for example, ```fdisk``` and create a primary partition choosing ```8e``` option to specify Linux LVM partition type.
 Below is the screenshot of the list of possible partition types in Ubuntu 16.04:
 ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/LVM/8E.PNG)
 
 
The second way is to create an LVM partition is without a partition table. To do this we add a new hard drive and type ```pvcreate /dev/sd*```. 

Below is the screenshot showing the output of the command ```lsblk```, where two LVM partitions are displayed.
***sdd1*** - with a parittion table and and ***sdc*** without
 ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/LVM/withwithout.PNG)
 
 Below is the table comparing two types of set up of LVM partition:
 
 
| Comparison Criteria | LVM with Partition Table | LVM with no Partition Table |
| :-----------:       |     :-------------:      |     :---------------------: |
| Creation of a New Volume | Additional disk management utils have to be used (e. g. fdisk, parted) to create partition table for PV.    | PV can be created straight away.  |
| Extension  of Existing Volume      | Partitions for PV can be extended since there might be some space left on disk.   | LVM PV cannot be extended as usually the whole disk is used for PV.     |
| Shrinkage of Existing Volume       | Partitions for PV can be reduced and the space left used for other purposes.     |  It is not recommended to shrink LVM PV as the space that will be left cannot be appropriately used for another PV.   |
| Data Restore on External Server    | With partition table, the data about partitions contains info on what was on the disk.   | In case you check for available devices with commands ```fdisk -l``` or ```parted -l```, the devices with LVM logical volumes seem to be empty. It often happens that disk gets overwritten with new info because of it. However, if you check the output of ```lsblk``` command it will show whether the device is a part of volume group and logical volume or not.  |

* There is one more thing that needs to be mentioned regarding the output of the ```fdisk -l``` and ```parted -l```. 
Since LVM  uses device mapper to represent volume groups as block devices, these block devices are shown in the output of the aforementioned commands. This may serve as a hint that LVM is used in the system.
Although there seems to be no correlation between the mapped and the real device this should urge the user to at least check ```lsblk``` command and see if there are LVM logical volumes on available devices.
Below are the screenshots that display comparison of the commands:
1. ```lsblk``` vs ```fdisk -l```
 ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/LVM/fdisk.PNG)
2.  ```lsblk``` vs ```parted -l```
 ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/LVM/parted.PNG)
 
 As you can see from the screenshots above, the mapped devices show info about volume groups and LVM logical volumes. In case of ```parted -l``` even some additional information, namely start, end and file system type.
 
 ***Resources***
 
 1. https://www.howtogeek.com/howto/40702/how-to-manage-and-use-lvm-logical-volume-management-in-ubuntu/
 2. https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/4/html/Cluster_Logical_Volume_Manager/LVM_CLI.html
 3. https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Logical_Volume_Manager_Administration/VG_remove_PV.html
 4. https://www.slideshare.net/prakashrockz/red-hat-lvm-cheatsheet
 5. https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Logical_Volume_Manager_Administration/device_mapper.html
 




