
### **Network Configuration in Linux** ###
-------
*Topics covered:*

1. SSHD;
2. Private and Public Keys explained;
2. SSH keys manual setup;
3. SSH keys setup using a command;
4. Results;
5. Resources.


***SSHD***
-------------

***Private and Public Keys explained;***
-------------

***SSH keys manual setup***
-------------
 * to create a keypair we need to type the command: ```ssh-keygen``` on the machine from which we are going to be connecting to another VM. Below is the output of this command, all the options are left blank.
 ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Screen%20Shot%202017-07-25%20at%2023.39.41.png) 
 * After this is done a folder ~/.ssh is created with three default files: id_rsa (private key), id_rsa.pub (public key), known hosts (contains DSA host keys of SSH servers accessed by the user). 
 * DSA is faster in signing, but slower in verifying. A DSA key of the same strength as RSA (1024 bits) generates a smaller signature. An RSA 512 bit key has been cracked, but only a 280 DSA key. 
 * Also note that DSA can only be used for signing/verification, whereas RSA can be used for encryption/decrypt as well.
 * Now we need to copy the public key from the machine where the keys were generated (which is CentOS 7 in this case) to another machine (which is Ubuntu, just as an example) to which we need to connect without password authentification. To do this we type the command:
 ```scp ~/.ssh/id_rsa.pub user@remote.example.com:/tmp/id_rsa.pub``` - in our case we used ip address of the Ubuntu VM.
  ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Screen%20Shot%202017-07-25%20at%2023.55.12.png) 
 * You can see that when copying the keys a password of this Ubuntu needs to be typed.
 * Now we can create a directory .ssh to our destination machine (Ubuntu). Permission 700 should be enough for this folder.
 * Then we move the public key to this folder using the following command ```cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys```. On the screenshot below you may see that the public key (id_rsa.pub) from CentOS VM is now stored in ~/.ssh/authorized_keys file on the Ubuntu VM.
 ![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Screen%20Shot%202017-07-26%20at%2000.09.40.png) 
 * The last step is to check access without a password. The screenshot below shows that once the public key generated on CentOS VM is in the ~/.ssh/authorized_keys, we can connect via ssh to Ubuntu machine without typing password.
![ScreenShot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/Screen%20Shot%202017-07-26%20at%2000.10.55.png) 


***SSH keys setup using a command***
--------------- 


 
 ***Results*** 
 As a result we have tried two ways to create key pairs.
 
 ***Resources***
 
 1. https://unix.stackexchange.com/questions/29386/how-do-you-copy-the-public-key-to-a-ssh-server
 2. https://stackoverflow.com/questions/2841094/what-is-the-difference-between-dsa-and-rsa
 
