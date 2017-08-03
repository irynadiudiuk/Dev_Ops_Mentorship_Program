
### **KEY-BASED AUTHENTICATION** ###
-------
*Topics covered:
1. SSH keys manual setup;
2. SSH keys setup using a command;
3. SSH Agent and SSH Forwarding;
4. Results;
5. Resources.

***SSH keys manual setup***
-------------
 * To create a keypair we need to type the command: ```ssh-keygen``` on the machine from which we are going to connect to another VM. Below is the output of this command, all the options are left blank.
 ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Network_Configuration_in_Linux/Screen%20Shot%202017-07-25%20at%2023.39.41.png)  
 * After this is done, a folder ~/.ssh is created with three default files: id_rsa (private key), id_rsa.pub (public key), known hosts (contains DSA host keys of SSH servers accessed by the user). 
 * DSA is faster in signing, but slower in verifying. A DSA key of the same strength as RSA (1024 bits) generates a smaller signature. DSA can only be used for signing/verification, whereas RSA can be used for encryption/decrypt as well.
 * Now we need to copy the public key from the machine where the keys were generated (which is CentOS 7 in this case) to another machine to which we need to connect without password authentification (which is Ubuntu, just as an example). To do this we type the command: ```scp ~/.ssh/id_rsa.pub user@remote.example.com:/tmp/id_rsa.pub``` - in our case we used ip address of the Ubuntu VM.
  ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Network_Configuration_in_Linux/Screen%20Shot%202017-07-25%20at%2023.55.12.png) 
 * You can see that when copying the keys a password of this Ubuntu needs to be typed.
 * Now we can create a directory .ssh to our destination machine (Ubuntu). Permission 700 should be enough for this folder.
 * Then we move the public key to the appropriate folder using the following command ```cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys```. On the screenshot below you may see that the public key (id_rsa.pub) from CentOS VM is now stored in ~/.ssh/authorized_keys file on the Ubuntu VM.
  ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Network_Configuration_in_Linux/Screen%20Shot%202017-07-26%20at%2000.09.40.png) 
 * The last step is to check access without a password. The screenshot below shows that once the public key generated on CentOS VM is in the ~/.ssh/authorized_keys, we can connect via ssh to Ubuntu machine without typing password.
  ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Network_Configuration_in_Linux/Screen%20Shot%202017-07-26%20at%2000.10.55.png) 
 * For security reasons keys pair displayed on the screenshots has been removed from both machines.

***SSH keys setup using a command***
--------------- 
To configure authentification based on ssh keys the following steps should be taken:
1. generate a new keys pair if necessary using the command ```ssh-keygen```
2. on the VW where a new key pair is generated we need to type the following command ```ssh-copy-id``` followed by the username and hostname of the user on the machine to which we are going to be connecting. In case the passphrase is chosen while the key pair was generated, the passphrase needs to be inserted while connecting to the VM. below is the screenshot of the result:
 ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SSH_Keys_Set_Up/Screen%20Shot%202017-07-28%20at%2010.08.07.png) 

***SSH Agent***
-------------
 * After the keys are set up, we can use SSH Agent program to store our keys and set them on the servers we want to connect to. To do that we need to Start the ssh-agent in the background with command ```eval "$(ssh-agent -s)"```. Then we need to add the key to the SSH Agent using the following command: 
 
 ```ssh-add -K ~/.ssh/id_rsa```
 
 To see if the key is visible to SSH Agent we can use the command: 
 
 
 ```ssh-add -L```
 
 After that we need to make sure that in the config file ```/etc/ssh/ssh_config``` ForwardAgent value on the client machine is set to _yes_ as on the screenshot below: ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SSH_Keys_Set_Up/forward-yes.png) 
 * On Mac OS X, ssh-agent will "forget" this key, once it gets restarted during reboots. But you can import your SSH keys into Keychain using this command: 
 
 ```/usr/bin/ssh-add -K ~/.ssh/id_rsa```
 
 
 * When the agent starts, it creates a new directory in /tmp/ with restrictive permissions (0700), and creates it's socket there with similarly restrictive permissions (0600). Agent keys are usable by root user, however, they are only usable while the agent is running. 
 * If you supply the -c option when you import your keys into the agent, then the agent will not allow them to be used without confirmation. Type command: ```ssh-add -c```. When someone attempts to use agent to authenticate to a server, the ssh-agent will run the ssh-askpass program. However, this will prevent root on machines to which we've forwarded the agent from accessing your agent.
 
 ***Agent Forwarding***
 -------------
  * The default in newer versions of OpenSSH is to disable agent forwarding by default. The agent is running on one machine, and each time you SSH with agent forwarding, the server creates a 'tunnel' back through the SSH connection to the agent so it's available for any further SSH connections. To forward your agent via the command line, just include a -A flag:

   ```ssh -A user@remotehost```. 
   
  * It should be pointed out that ForwardAgent in SSH_config must be set to _yes_ on the client machine and AllowTCPForwarding should be set to _yes_ on the server machine in the sshd_config. Below is the screenshot of the sshd_config on the distination machine. ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SSH_Keys_Set_Up/Screen%20Shot%202017-08-03%20at%2023.53.52.png).
   And here is the screenshot from the ssh_config from the client machine: 
   ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SSH_Keys_Set_Up/Screen%20Shot%202017-08-03%20at%2023.57.39.png)
   Here is what needs to be done to set up agent forwarding in a nutshell:
1. generate key pair with passphrase;
2. set up ssh_config (forward agent) and sshd_config (allowforwarding)
3. start ssh-agent process
4. use ssh-add command to add key to agent and enter correct passphrase
5. copy id_rsa to the remote machine
6. enter password to that machine
Below is the output of the ssh -v command showing that the forwarding in working:
![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SSH_Keys_Set_Up/Screen%20Shot%202017-08-04%20at%2002.21.23.png)

 
 ***Results*** 
 As a result we have tried two ways of creating ssh key pairs, used key-based authentication to connect to remote machines, created key pairs with passphrase, added keys to ssh agent and used ssh forwaring to connect to remote machines without entering the passphrase.
 
 
 ***Resources***
 
 1. https://unix.stackexchange.com/questions/29386/how-do-you-copy-the-public-key-to-a-ssh-server
 2. https://stackoverflow.com/questions/2841094/what-is-the-difference-between-dsa-and-rsa
 3. https://github.com/irynadiudiuk/Linux_Fundamentals/edit/master/SSH_Keys_Set_Up/SSH_Keys_Set_Up.md
 4. https://www.youtube.com/watch?v=CVbOHZty7j0
 
