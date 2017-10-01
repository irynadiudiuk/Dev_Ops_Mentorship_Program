

### **Custom Service Creation** ###

*Plan:*
1. Basic Coincepts;
2. Task;
3. Resources.

-------
***Basic Coincepts***




*Task:*

The goal of this task is to create a custom service and will start at boot time and will work with ```systemctl``` command
The task consists of the following steps:

1. Prepare Script for the Service;
2. Prepare Unit File;
3. Enable Service to Start an Boot Time ;

1. The simple script was created and put into home directory of the user. Below you can see the screenshot of this script.
The script should be executable that is why one of the following commands needs to be used ```sudo chmod 755 checker.sh``` or ```chmod a+x checker.sh```, you need to insert the name of your script instead of "checker.sh" it is used here as an example.
This script can be placed in any directory.
Below you can see the screenshot of this script.
![ScreenShot]


2. Second step is to prepare the unit file.  
This file needs to be created on the following path */etc/systemd/system/*. It should have *644* permissions. The name of this file should indicate the type of the unit. In this case we are creating a service unit that is why our file is called *checker.service*. 
Every unit in systemd has a definite structure. It includes the desctiption of the service the unit performs, the path to the executable file, the services it depends on and the services that depend on this unit. The structure of the unit files in described in detail by the following link: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/sect-managing_services_with_systemd-unit_files 

Below you can see the structure of *checker.service* unit.
![ScreenShot]

The WantedBy option in the [INSTALL] section indicates that the unit with start after the system reaches the default target. To check what target in the default one on your system use ```systemctl get-default```. Below are the screenshots displying the output of this command:
![ScreenShot]


The graphical target can be compared to the runlevel 5 on the sys V init system. It is the default target for the Ubuntu Desktop Installation.
The multi-user target is in most cases the defaylt target for server installations. On this screenshot above multi-user target is from the Centos7.
 
3. To enable a service to start on boot the following command is used: ```systemctl enable checker.service```. Checker is the name of the service we use in this example. You need to insert the appropriate name of the service you would like to enable instead of "checher" in this command. Below in the screenshot of this command:
![ScreenShot]

On the screenshot you can see that the symlink is created from the ***/etc/systemd/system/default.target.wants/*** to the /etc/systemd/system/checker.service.
The message about creation on soft link is an indicator that the service in enabled. To check the status of the service use the command ```systemctl status checker.service``` (do not forget to replace the name of the service with thecorrect one for you).
To view the list of all enables services the the command: ```systemctl list-unit-files --type service --state enabled```. Below is the screenshot displaying the output:
![ScreenShot]

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


```pvcreate /dev/sd(any)``` -  to create physical volume. *(any)* here implies any device of your choosing (sdb, sdc, sdd1).

```vgcreate vgroup1 /dev/sd(any)``` - to create volume group with the name vgroup1

```pvscan/vgscan/lvscan``` - to see information on physical volumes, volume groups or logical volumes correspondently (can be used in form of ```pvs,vgs,lvs```)

![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/LVM/vgs.PNG)


```lvcreate -L+3G -n lv1 vgroup1``` - to  create a logical volume name lv1 using vgroup1

```mkfs -t ext4 /dev/vgroup1/lv1``` - to format new lv with a file system

```mkdir /mnt/lvmp```  - to create a mount point for a new volume group

```mount /dev/vgroup1/lv1 /mnt/lvmp``` - to mount logical volume called lv1 into the folder /mnt/lvmp

```vgextend vgroup1 /dev/sdany``` - to extend vg with newly added hard drive

```lvextend -L8G /dev/vgroup1/lv1``` - to extend to up to a 8G

```lvextend -L+3G /dev/vgroup1/lv1``` - to add 3G

```resize2fs /dev/vgroup1/lv1``` - to resize lv (before that e2fck -f /dev/vgroup1/lv1/ needs to be run)

```lvextend -L-0.65Gib /dev/vgroup1/lv1``` - to reduce 0.65Gib

```lvcreate -L512M -s -n lv1backup /dev/vgroup1/lv1``` - to create a snapshot

```lvremove /dev/vgroup1/lv1``` - to remove logical volume

```vgremove vgroup1``` - to remove volume group

```pvremove /dev/sd(any)```  - unmount and remove more than one physical volume


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
 




