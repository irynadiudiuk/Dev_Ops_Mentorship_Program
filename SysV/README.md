

### **Custom Service Creation with System V** ###

*Plan:*

1. Basic Concepts;
2. Task;
3. Resources.

-------
***Basic Concepts***

- When init process starts, it becomes the parent (with PID=1) or grandparent of all of the processes that start up automatically on Linux system. 
- The first thing init does, is reading its initialization file, ```/etc/inittab```. This instructs init to read an initial configuration script for the environment, which sets the path, starts swapping, checks the file systems.
- None of the scripts that start and stop the services are located in ```/etc/rc<x>.d/```. All of the files there are symbolic links that point to the actual scripts located in ```/etc/init.d/```. These links can be created or deleted without affecting the actual scripts that kill or start the services. 
- The symbolic links to the various scripts are numbered in a particular order so that they start or be killed in that order. You can change the order in which services start or are killed by changing the name of the symbolic link that refers to the script that controls the service.
- The letter "S" at the beginning of the link indicates that the process should start and the letter "K" that the process should be killed. **"S09myservice"** - this name of the link implies that the process will be started and will be the 9th in the queue to be started on that runlevel.
- If the same number is used multiple times, a particular service with this number will be started or stopped  at the same time as other services with this number.
____________________________________________
 

*Task:*

The goal of this task was to create a custom service that will on it's start create a file and delete the same file when this service is stopped. It will work with runlevel 2. This task is done on Centos 6.5 since SysV is the init system for this version, while Centos 7 uses systemd as a primary init system. When the same steps were done on Centos 7, there was a problem switching runlevels. (the command ```systemctl isolate runlevel2.target``` did not work). Also starting a service with ```service myservice start``` command did not work. 


The task consists of the following steps:

1. Prepare script for the service (service file);
2. Create a link to a service file in a folder of the chosen run level and then change name of this link to display the order with whoich the process will start;
3. Switch to the chosen runlevel and test the service;

_____________________

1. The simple script was created and put into the following directory ```/etc/init.d/```
The script should be executable that is why one of the following commands was used ```sudo chmod 755 myservice``` or ```chmod +x myservice```, you need to insert the name of your script instead of "myservice" as it is used here as an example.


Below you can see the screenshot of the service file.
![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SysV/script.png)

____________________

2. Second step is to create a link in the folder with the name of the runlevel on which the script will be working. The task was to make this script work on the second runlevel. That is why the link was created from the directory ```/etc/rc.d/rc2.d```  to an execuable service file that was previously set in the directory ```/etc/init.d/myservice```.

Below you can see that the symbolic link was been created and then renamed to indicate the order in which the script would be executed in the example we chose the script to start with #9.
![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SysV/link%20created%20and%20renamed.png)

_______________________________________
 
3. After the script was tested the command ```init 2``` was used to switch the the second runlevel. Then to check that the system is on an appropriate runlevel we used ```who -r``` command, another way to check it would be to use ``` runlevel``` command. Below you can see the screenshot showing that the script is executed as a service of System V on the second runlevel.
![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SysV/service%20is%20working.png)

 
 ***Resources***
 
1. https://www.youtube.com/watch?v=0XdjODvsRN8&list=PLtK75qxsQaMLZSo7KL-PmiRarU7hrpnwK&index=17
2. https://unix.stackexchange.com/questions/115495/how-to-find-out-in-which-order-etc-init-d-scripts-are-load-on-debian
3. https://www.cs.auckland.ac.nz/references/unix/digital/AQTLLATE/DOCU_002.HTM
4. http://www.tldp.org/LDP/intro-linux/html/sect_04_02.html
5. https://shabirimam.wordpress.com/2009/03/10/adding-script-to-run-at-startup-or-shutdown/


