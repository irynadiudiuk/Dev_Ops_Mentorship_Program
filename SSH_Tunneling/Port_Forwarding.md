### ***SSH PORT FORWARDING*** ###
-------

***Environment and Goal of the task***
1. In this task we are creating ssh tunnel from AWS (Centos7) instance to local VM (Centos7). 
2. We are using local machine (macOS) to set up this tunnel.
3. On VM, Nginx server is installed on port 80.
4. The goal is to create a tunnel from AWS to VM that will forward requests to port 80 of the VM while connecting to port 1234 on AWS.
5. To check the configuration of the tunnel we are connecting to AWS instance's address and forwarded port. 
6. If tunneling is working correctly we will be forwarded to Ngix installed on port 80 of the VM.

Below is the picture displays the type of connection we are creating:
![Screenshot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SSH_Tunneling/pic.png)

***Steps taken to set up ssh tunneling:***

1. SSH agent started.
2. SSH Keys added via ssh-add command and key-based authentication checked.
3. Agent forwarding configured on machines Mac, VM and AWS. 
4. In sshd_config three options changed to _'yes'_: *AllowTCPForwarding*,*AllowAgentForwarding*,*GatewayPorts*.
5. In ssh_config option *ForwardAgent* changed to _'yes'_.
6. Security group setting configured and new inbound rule added to open the port e.g. p1234 on AWS. 
7. Remote port forwarding set up from AWS instance (e.g. port 1234) to VM port 80 (running ssh -R on VM). 
To do this we used the command ```ssh -N -f -R 1234:localhost:80 ec2-user@52.36.164.219```.
(*-N* option means that the user will not execute a remote command. It requests ssh to go to background just before command execution. This is useful if ssh is going to ask for passwords or passphrases, but the user wants it in the background.
*-f* option requests ssh to go to background just before command execution. 
This is useful if ssh is going to ask for passwords or passphrases, but the user wants it in the background).
8. After the command is executed the ports both on VM and on AWS instance were checked. The screenshots below show that the appropriate ports were opened:
netstat on VM
![Screenshot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SSH_Tunneling/vm.png) 
netstat on AWS
![Screenshot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SSH_Tunneling/ec2.png) 
9. Now that the ports are proved to be open we can check if the tunnel is working. The screenshot below shows that the user is connected to Nginx server via AWS instance.
![Screenshot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SSH_Tunneling/nginx.png) 

