

### **Custom Service Creation** ###

*Plan:*
1. Basic Concepts;
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

_____________________

1. The simple script was created and put into home directory of the user.
The script should be executable that is why one of the following commands needs to be used ```sudo chmod 755 checker.sh``` or ```chmod a+x checker.sh```, you need to insert the name of your script instead of "checker.sh" it is used here as an example.
This script can be placed in any directory.
Below you can see the screenshot of this script.
![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SystemD/ll.checker.sh.png)
![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SystemD/checker.sh.png)

____________________
2. Second step is to prepare the unit file.  
This file needs to be created in the following directory */etc/systemd/system/*. It should have *644* permissions. The name of this file should indicate the type of the unit. In this case we are creating a service unit that is why our file is called *checker.service*. 
Every unit in systemd has a definite structure. It includes the desctiption of the service the unit performs, the path to the executable file, the services it depends on and the services that depend on this unit. 

The structure of the unit files in described in detail by the following link: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/sect-managing_services_with_systemd-unit_files 

Below you can see the structure of *checker.service* unit.
![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SystemD/unit.file.png)

The WantedBy option in the [INSTALL] section indicates that the unit with start after the system reaches the default target. To check what target in the default one on your system use ```systemctl get-default```. Below are the screenshots displying the output of this command:
![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SystemD/graphical.png)
![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SystemD/multiuser.png)


The graphical target can be compared to the runlevel 5 on the sys V init system. It is the default target for the Ubuntu Desktop Installation.
The multi-user target is in most cases the default target for server installations. On this screenshot above multi-user target is the default on for the Centos7 VM.
 _______________________________________
 
3. To enable a service to start on boot the following command is used: ```systemctl enable checker.service```. Checker is the name of the service we use in this example. You need to insert the appropriate name of the service you would like to enable instead of "checker" in this command. Below in the screenshot of this command:
![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SystemD/symlink.png)

On the screenshot you can see that the symlink is created from the ***/etc/systemd/system/default.target.wants/*** to the /etc/systemd/system/checker.service.
The message about creation on soft link is an indicator that the service in enabled. To check the status of the service use the command ```systemctl status checker.service``` (do not forget to replace the name of the service with the correct one for you).
To view the list of all enabled services the the command: ```systemctl list-unit-files --type service --state enabled```. Below is the screenshot displaying the output:
![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SystemD/checker.png)

 
 ***Resources***
 
 1. https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/sect-managing_services_with_systemd-services
 2. UNIX and Linux System Administration Handbook


