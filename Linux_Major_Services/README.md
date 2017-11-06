

#  Major Services in Linux

*Plan:*

1. Init Process;
2. Scheduling Service;
3. Network File Systems;
4. Mail Service;
5. Printing Service;
6. DNS Service and its Configuration;
7. Telnet;
8. Resources.

-------
# ***Init Process***


Init is the first process started during the "bootstrapping" and is also on the most important services in Linux system. It is the last thing the kernel does when it boots. When init starts, it performs various startup functions, namely: checking and mounting filesystems, starting daemons, etc.

init usually provides the concept of run levels, also called modes (e.g. single user mode and multiuser mode being the two most used). Linux allows for up to 10 runlevels, 0-9, but usually only some of these are defined by default. 

***Runlevel 0*** is defined as "system halt".
***Runlevel 1*** is defined as "single user mode". 
***Runlevel 3*** is defined as "multi user" because it is the runlevel that the system boot into under normal day to day conditions. 
***Runlevel 5*** is typically when the GUI gets started.
***Runlevel 6*** is defined as "system reboot". 
Other runlevels are dependent on particular distribution, and may vary significantly. The contents of ```/etc/inittab``` give some hint about what the predefined runlevels are and what they have been defined as.

In normal operation, init makes sure ***getty*** is working (to allow users to log in) and to adopt orphan processes.
When the system is shut down, it is init that is in charge of killing all other processes, unmounting all filesystems and stopping the processor, along with anything else it has been configured to do.
      
____________________________________________

# ***Scheduling Service***

 Each user can have a ```crontab``` file, with the commands to execute and the times they should be executed. The cron daemon takes care of starting the commands when specified.

The crontab files are stored where the lists of jobs and other instructions to the cron daemon are kept. Users can have their own individual crontab files and often there is a system-wide crontab file (usually in ```/etc``` or a subdirectory of ```/etc```) that only system administrators can edit.

The configuration file for a user can be edited by calling ```crontab -e``` regardless of where the actual implementation stores this file.

These two files play an important role:

```/etc/cron.allow``` - If this file exists, it must contain your username for you to use cron jobs.
```/etc/cron.deny``` - If the cron.allow file does not exist but the /etc/cron.deny file does exist then, to use cron jobs, you must not be listed in the /etc/cron.deny file.
Note that if neither of these files exist then, depending on site-dependent configuration parameters, either only the super user can use cron jobs, or all users can use cron jobs.


The ```at``` service is similar to cron, but it is once only: the command is executed at the given time, but it is not repeated. Here is an example of the command ```echo "at command output" | at 1145 jan 31```
____________________________________________

# ***Network File Systems***

A Network File System (NFS) allows remote hosts to mount file systems over a network and interact with those file systems as though they are mounted locally. This enables system administrators to consolidate resources onto centralized servers on the network.
TCP is the default transport protocol for NFS version 2 and 3 under Red Hat Enterprise Linux. UDP can be used for compatibility purposes as needed, but is not recommended for wide usage. NFSv4 requires TCP.
All the RPC/NFS daemons have a '-p' command line option that can set the port, making firewall configuration easier.
In order for NFS to work with a default installation of Red Hat Enterprise Linux with a firewall enabled, IPTables with the default TCP port 2049 need to be configured. Without proper IPTables configuration, NFS will not function properly.
The NFS initialization script and ```rpc.nfsd``` process now allow binding to any specified port during system start up. However, this can be error-prone if the port is unavailable, or if it conflicts with another daemon.
____________________________________________

# ***Mail Service***

An electronic letter is stored in a file using a special format, and special mail programs are used to send and read the letters.

Each user has an incoming mailbox (a file in the special format), where all new mail is stored. When someone sends mail, the mail program locates the receiver's mailbox and appends the letter to the mailbox file. If the receiver's mailbox is in another machine, the letter is sent to the other machine, which delivers it to the mailbox as it best sees fit.

The mail system consists of many programs. The delivery of mail to local or remote mailboxes is done by one program (the mail transfer agent (MTA) , e.g., sendmail or postfix ), while the programs users use are many and varied (mail user agent (MUA) , e.g., pine , or evolution .	The mailboxes are usually stored in ```/var/spool/mail``` until the user's MUA retrieves them.

Postfix is a free and open-source mail transfer agent (MTA) that routes and delivers electronic mail.
Postfix has several hundred configuration parameters that are controlled via the main.cf file. Fortunately, all parameters have sensible default values. By default, Postfix configuration files are in /etc/postfix. The two most important files are main.cf and master.cf; these files must be owned by root. Giving someone else write permission to main.cf or master.cf (or to their parent directories) means giving root privileges to that person.

____________________________________________

# ***Printing Service***

The printer is managed by software that implements a print queue: all print jobs are put into a queue and whenever the printer is done with one job, the next one is sent to it automatically. This relieves the users from organizing the print queue and fighting over control of the printer. 
A popular way to print in the Linux operating system is to send the file to be printed directly to the printing device. One way to do this is to use the cat command. As the root user, one could do something like

 ```cat thesis.txt > /dev/lp```
 
Users use ``lpr`` to print a file. For example ```$ lpr [ options ] [ filename ... ]``` The lpr command takes care of all the initial work needed to print the file, and then it hands control over to another program, ``lpd``, the line printing daemon. The line printing daemon then tells the printer how to print the file.

The root user and users in the same group as the print daemon are able to write directly to the printer. For this purpose commands such as ```lpr```, ``lprm``, and ``lpq`` have to be used to access the printer.


To view the contents of the print queue, the ```lpq``` command is used. 
```lprm -``` is used to remove jobs from printing queue. If only one job needs to be cancelled, then command ```lprm #``` can be used, where # is the number of the job according to the ```lprq``` command.

____________________________________________

# ***DNS Service and its Configuration***


The Domain Name System (DNS) is a hierarchical decentralized naming system for computers, services, or other resources connected to the Internet or a private network. It associates various information with domain names assigned to each of the participating entities. 


The most common types of records stored in the DNS database are for ***Start of Authority (SOA)***, ***IP addresses (A and AAAA)***, **SMTP mail exchangers (MX)**, **name servers (NS)**, **pointers for reverse DNS lookups (PTR)**, and ***domain name aliases (CNAME)***. Although not intended to be a general purpose database, DNS can store records for other types of data for either automatic lookups, such as DNSSEC records, or for human queries such as ***responsible person (RP)*** records. 
As a general purpose database, the DNS has also been used in combating unsolicited email (spam) by storing a real-time blackhole list. The DNS database is traditionally stored in a structured zone file.


The client side of the DNS is called a DNS resolver. A resolver is responsible for initiating and sequencing the queries that ultimately lead to a full resolution (translation) of the resource sought, e.g., translation of a domain name into an IP address. An individual DNS query may be either non-recursive, recursive, or iterative, or a combination of these.


A DNS hosting service is a service that runs Domain Name System servers. Most, but not all, domain name registrars include DNS hosting service with registration. Free DNS hosting services also exist. Many third-party DNS hosting services provide Dynamic DNS.

Domain Name System is responsible for translating Internet domain and hostnames to IP addreses and vice versa. Domain Name System clients are sending requests (hostname or IP addresses) to the DSN server and wait for the response. These requests are called DNS lookup requests. There are two types of requests:
```Forward lookup``` resolves hostnames to IP addresses;
```Reverse lookup``` resolves IPaddresses to host and domain names

The screenshot below shows this process: 

![Screenshot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Linux_Major_Services/Screen%20Shot%202017-11-04%20at%2016.26.42.png)
____________________________________________

# TELNET

Telnet is a protocol used on the Internet or local area networks to provide a bidirectional interactive text-oriented communication facility using a virtual terminal connection. User data is interspersed in-band with Telnet control information in an 8-bit byte oriented data connection.


Telnet is a client-server protocol, based on a reliable connection-oriented transport. Typically, this protocol is used to establish a connection to Transmission Control Protocol (TCP) port number 23, where a Telnet server application (telnetd) is listening. 


Telnet, however, predates TCP/IP and was originally run over Network Control Program (NCP) protocols.
The syntax is to type the command telnet, the IP or hostname to connect to, and the remote port (otherwise it will default to port 23—the default port for telnet). To test a Web server instead, I would connect to the HTTP port (port 80):

```$ telnet www.example.net 80```


____________________________________________
 
 # ***Resources***
 
1. http://www.tldp.org/LDP/sag/html/major-services.html
2. https://en.wikipedia.org/wiki/Cron
3. https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Storage_Administration_Guide/ch-nfs.html
4. https://en.wikipedia.org/wiki/Domain_Name_System
5. http://www.postfix.org/BASIC_CONFIGURATION_README.html
6. https://en.wikipedia.org/wiki/Telnet
7. http://www.linuxjournal.com/content/troubleshooting-telnet
