### **Network Configuration in Linux** ###
-------
*Topics covered:*

1. Environment (VMs)
2. Network Adapter Configuration for Centos (7 and 6.5)
3. Network Adapter Configuration for Ubuntu (16.04)
4. Networking Services Restart

***Environment***
-------------
To be able to set up network adapters we need to have the following things set up:
 * [Virtual box installed](https://www.google.com) for an appropriate host machine;
 * VM downloaded and installed into Virtual box. We are going to use three images [Ubuntu](https://www.ubuntu.com/download), [Centos 7](http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1611.iso) and [Centos 6.5](http://mirror.nsc.liu.se/centos-store/6.5/isos/x86_64/);
 * For all of the machines we had NAT (Network Address Translation) network adapter choosen as the default interface that will connect the machine to other machines and the Internet;
 * Choose host-only network adapter for a second adapter.

***Network Adapter Configuration for Centos (7 and 6.5)***
-------------
 * type ```ip a``` command to view availabe interfaces. **lo** - is the default virtual network interface that a computer uses to communicate with itself. **enp0s3** - the defualt name of the interface for the NAT adapter. In case the second adapter is in "cable connected" state it's default name is **enp0s8** and it is dispalyed as the third network interface.
 Here is the example of the output when two adapters are turned on:
 ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Screen%20Shot%202017-07-25%20at%2000.24.00.png)
 
 * notice that in Centos (7 and 6.5) networks configuration files are stored on the following path: 
 _cd /etc/sysconfig/network-scripts/_;
 * to edit the file for the second interface and choose it to either use a DHCP server provided by Virtual box or a static ip address we need to open the file with available text editor using the following command: ``` sudo vim ifcfg-enp0s8``` (as **ifcfg-enp0s8** is the name of the file for the third, in our case, host-only network interface. 
 * In this scenario we are going to assign a static ip address for our network interface. For this we need to set up both Virtual box and our VM. Below are the screenshots:  
 
 
|Virtual Box|
![Screenshot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Screen%20Shot%202017-07-25%20at%2000.34.52.png) 

|Configuration File| 
![Screenshot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Screen%20Shot%202017-07-25%20at%2000.36.44.png) 

Here is a link for some more information on configuration of network adapter in Centos (7 and 6.5):
https://www.centos.org/docs/5/html/Deployment_Guide-en-US/s1-networkscripts-interfaces.html


* last step is to restart network service ```service network restart```


