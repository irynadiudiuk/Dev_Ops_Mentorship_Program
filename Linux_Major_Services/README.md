

### **Major Services in Linux** ###

*Plan:*

1. Init Process;
2. Scheduling Service;
3. Network File Systems;
4. Mail Service;
5. Printing Service;
6. DNS Service and its Configuration;
7. Resources.

-------
***Init Process***
Init is the first process started during the "bootstrapping" and is also on the most important services in Linux system. It is the last thing the kernel does when it boots. When init starts, it performs various startup functions, namely: checking and mounting filesystems, starting daemons, etc.

init usually provides the concept of rum levels, also called modes (e.g. single user mode and multiuser mode being the two most used). Linux allows for up to 10 runlevels, 0-9, but usually only some of these are defined by default. 

***Runlevel 0*** is defined as "system halt".
***Runlevel 1*** is defined as "single user mode". 
***Runlevel 3*** is defined as "multi user" because it is the runlevel that the system boot into under normal day to day conditions. 
***Runlevel 5*** is typically when the GUI gets started.
***Runlevel 6*** is defined as "system reboot". 
Other runlevels are dependent on particular distribution, and may vary significantly. The contents of ```/etc/inittab``` give some hint about what the predefined runlevels are and what they have been defined as.

In normal operation, init makes sure ***getty*** is working (to allow users to log in) and to adopt orphan processes.
When the system is shut down, it is init that is in charge of killing all other processes, unmounting all filesystems and stopping the processor, along with anything else it has been configured to do.
      
____________________________________________

***Scheduling Service***

 Each user can have a ```crontab``` file, which the commands to execute and the times they should be executed. The cron daemon takes care of starting the commands when specified.

The crontab files are stored where the lists of jobs and other instructions to the cron daemon are kept. Users can have their own individual crontab files and often there is a system-wide crontab file (usually in ```/etc``` or a subdirectory of /etc) that only system administrators can edit.

The configuration file for a user can be edited by calling crontab -e regardless of where the actual implementation stores this file.

These two files play an important role:

```/etc/cron.allow``` - If this file exists, it must contain your username for you to use cron jobs.
```/etc/cron.deny``` - If the cron.allow file does not exist but the /etc/cron.deny file does exist then, to use cron jobs, you must not be listed in the /etc/cron.deny file.
Note that if neither of these files exist then, depending on site-dependent configuration parameters, either only the super user can use cron jobs, or all users can use cron jobs.


The ```at``` service is similar to cron, but it is once only: the command is executed at the given time, but it is not repeated. Here is an example of the command ```echo "at command output" | at 1145 jan 31```
____________________________________________

***Network File Systems***

A Network File System (NFS) allows remote hosts to mount file systems over a network and interact with those file systems as though they are mounted locally. This enables system administrators to consolidate resources onto centralized servers on the network.
TCP is the default transport protocol for NFS version 2 and 3 under Red Hat Enterprise Linux. UDP can be used for compatibility purposes as needed, but is not recommended for wide usage. NFSv4 requires TCP.
All the RPC/NFS daemons have a '-p' command line option that can set the port, making firewall configuration easier.
In order for NFS to work with a default installation of Red Hat Enterprise Linux with a firewall enabled, IPTables with the default TCP port 2049 need to be configured. Without proper IPTables configuration, NFS will not function properly.
The NFS initialization script and ```rpc.nfsd``` process now allow binding to any specified port during system start up. However, this can be error-prone if the port is unavailable, or if it conflicts with another daemon.
____________________________________________

***Mail Service***

____________________________________________

***Printing Service***
____________________________________________

***DNS Service and its Configuration***

!Screenshot[https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Linux_Major_Services/Screen%20Shot%202017-11-04%20at%2016.26.42.png]
____________________________________________
 
 ***Resources***
 
1. http://www.tldp.org/LDP/sag/html/major-services.html
2. https://en.wikipedia.org/wiki/Cron
3. https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Storage_Administration_Guide/ch-nfs.html
