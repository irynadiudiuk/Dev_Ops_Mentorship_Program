### **Network Configuration in Linux** ###
-------
*Topics covered:*

1. Environment (VMs);
2. Network Adapter Configuration for CentOs 7;
3. Network Adapter Configuration for CentOs 6.5;
4. Network Adapter Configuration for Ubuntu 16.04


***Environment***
-------------
To be able to set up network adapters we need to have the following things set up:
 * [Virtual box](https://www.google.com) installed for an appropriate host machine;
 * Appropriate ISO image for VM downloaded and installed into Virtual box. We are going to use three images [Ubuntu](https://www.ubuntu.com/download), [CentOs 7](http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1611.iso) and [CentOs 6.5](http://mirror.nsc.liu.se/centos-store/6.5/isos/x86_64/);
 * For all of the machines we have NAT (Network Address Translation) network adapter choosen as the default interface;
 * We are going to configure host-only network adapter for a secondary network adapter.

***Network Adapter Configuration for CentOs 7***
-------------
 * type command:
 /<```ip a```>/ 
 to view availabe interfaces. **lo** - is the default virtual network interface that a computer uses to communicate with itself. **enp0s3** - the default name of the interface for the NAT adapter in CentOs 7. In case the second adapter is in "cable connected" state its default name is **enp0s8** and it is dispalyed as the third network interface.
 Here is an example of the output when two adapters are turned on:
 ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Screen%20Shot%202017-07-25%20at%2000.24.00.png)
 * in CentOs 7 network configuration files are stored on the following path: 
 ```/etc/sysconfig/network-scripts/```;
 * to edit the file for the second interface and choose it to either use a DHCP server provided by Virtual box or a static ip address we need to open the file with available text editor using the following command: ``` sudo vim ifcfg-enp0s8``` (as **ifcfg-enp0s8** is the name of the file for the third, in our case, host-only network interface. 
 * In this scenario we are going to assign a static ip address for our network interface. For this we need to set up both Virtual box and our VM. Below are the screenshots:  
 
 
|Virtual Box|
![Screenshot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Screen%20Shot%202017-07-25%20at%2000.34.52.png) 

|Configuration File| 
![Screenshot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Screen%20Shot%202017-07-25%20at%2000.36.44.png) 

Here is a link for some more information on configuration of network adapter in Centos (7 and 6.5):
https://www.centos.org/docs/5/html/Deployment_Guide-en-US/s1-networkscripts-interfaces.html


* Last step is to restart network service. To do it on CentOs, type the command:  ```service network restart``` or ```sudo /etc/init.d/network restart```.



***Network Adapter Configuration for CentOs 6.5***
 * type ```ip a``` command to view availabe interfaces. **lo** - is the default virtual network interface that a computer uses to communicate with itself. **eth0** - the default name of the interface for the NAT adapter in CentOs 7. The secondary adapter is called **eth1**. Below is the output of the comand ```ip a```
![Screenshot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Screen%20Shot%202017-07-25%20at%2010.29.06.png) 
* in CentOs 6.5 network configuration files are stored on the following path: 
 ```/etc/sysconfig/network-scripts/```;
* In CentOs 6.5 NAT interface adapter is called **eth0** and its configuration file **ifcfg-eth0**. For the secondary interface **eth1** a new file needs to be created, called **ifcfg-eth1**
* to edit the file for the second interface and choose it to either use a DHCP server provided by Virtual box or a static ip address we need to open the file with available text editor using the following command: ``` sudo vim ifcfg-eth1```. 
* Last step is to restart network service. To do it on CentOs, type the command:  ```service network restart``` or ```sudo /etc/init.d/network restart```.



***Network Adapter Configuration for Ubuntu (16.04)***
-------------
 * type ```ip a``` command to view availabe interfaces. **lo** - is the default virtual network interface that a computer uses to communicate with itself. **enp0s3** - the default name of the interface for the NAT adapter. In case the second adapter is in "cable connected" state its default name is **enp0s8** and it is dispalyed as the third network interface.
 Here is the example of the output when two adapters are turned on:
 ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Screen%20Shot%202017-07-25%20at%2009.46.48.png)
 
 * notice that in Ubuntu (16.04) network configuration files are stored on the following path: 
 ```/etc/network/``` in the file **interfaces**;
 * to edit the file for the second interface and choose it to either use a DHCP server provided by Virtual box or a static ip address we need to open the file with available text editor using the following command: ``` sudo vim /etc/network/interfaces``` 
 * In this scenario we are going to assign a static ip address for our network interface. Here is the screenshot from the file with secondary interface configured:
 
 |Configuration File| 
 ![Screenshot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Screen%20Shot%202017-07-25%20at%2009.54.44.png) 

* Last step is to restart network service. To do it on Ubuntu, type the command:  ```sudo service networking restart``` or ```sudo /etc/init.d/networking restart```.
