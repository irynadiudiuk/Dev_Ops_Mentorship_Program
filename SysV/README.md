

### **Custom Service Creation with System V** ###

*Plan:*

1. Basic Concepts;
2. Task;
3. Resources.

-------
***Basic Concepts***

____________________________________________


*Task:*

The goal of this task is to create a custom service that will on its start create a file and delete the same file that this service is stopped. It will work with runlevel 2.


The task consists of the following steps:

1. Prepare Script for the Service;i
2. Create a link to service file in the folder for chosen run level and the name changed to display the order of the process;
3. Switch to the chosen runlevel and test the service;

_____________________

1. The simple script was created and put into home directory ```/etc/init.d/```
The script should be executable that is why one of the following commands needs to be used ```sudo chmod 755 myservice``` or ```chmod +x myservice```, you need to insert the name of your script instead of "myservice" it is used here as an example.


Below you can see the screenshot of this script.
![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SysV/script.png)

____________________
2. Second step is to create a link in the folder with the name of the runlevel on which the script will be working. The task was to make this script work on the second runlevel. That is why the link was create from the directory ```/etc/rc.d/rc2.d```  to service file that was previously set in the directory ```/etc/init.d/myservice``.`

Below you can see that the symbolic link was been created and then renamed to indicate the order in which the script would be executed in the example we chose the script to start with #9.
![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SysV/link%20created%20and%20renamed.png)

_______________________________________
 
3. After the script was tested the command ```init 2``` was used to switch the the second runlevel. Then to check that the system is on an appropriate runlevel we used ```who -r``` command, another way to check it would be to use ``` runlevel``` command. Below you can see the screenshot showing that the script is executed as a service of System V on the second runlevel.
![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SysV/service%20is%20working.png)

 
 ***Resources***
 


