### ***SSH PORT FORWARDING*** ###
-------

***Environment and Goal of the task***
1. In this task we are creating ssh tunnel from AWS (Centos7) instance to local VM (Centos7). 
2. We are using local machine (macOS) to set up VM with Nginx on VBox. Nginx works on port 80.
3. We are using ssh agent to improve security.
4. The goal is to create a ssh tunnel from VBox VM to AWS Instance that will forward requests from port 1234 of the AWS Instance to port 80 of the VBox VM.
5. To check if configuration of the tunnel is set properly, we open IP address/DNS Name of the AWS Instance and the forwarded port with a web browser.
6. If port forwarding is set correctly we will see the default start page of Nginx.

Below is the picture displays the type of connection we are creating:
![Screenshot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SSH_Tunneling/pic.png)

***Steps taken to set up ssh tunneling:***

1. SSH agent started.
2. SSH Keys added via ssh-add command and key-based authentication checked.
3. Agent forwarding configured on machines Mac, VM and AWS (in ssh_config option *ForwardAgent* changed to _'yes'_).
4. In sshd_config three options changed to _'yes'_: *AllowTCPForwarding*,*AllowAgentForwarding*,*GatewayPorts*.
5. A new rule is added security group of the AWS Instance to allow incoming connections on port 1234.
6. Remote port forwarding set up from VBox VM port 80  to AWS instance port 1234 (running ssh -R on VM).
To do this we used the command ```ssh -N -f -R 1234:localhost:80 ec2-user@52.36.164.219```.
(-N option means that the user will not execute a remote command.
-f option requests ssh to go to background just before command execution. This is useful if ssh is going to ask for passwords or passphrases, but the user wants it in the background).
8. After the command is executed the ports both on VM and on AWS instance were checked. The screenshots below show that the appropriate ports were opened:
netstat on VM
![Screenshot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SSH_Tunneling/vm.png) 
netstat on AWS
![Screenshot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SSH_Tunneling/ec2.png) 
9.  Now that the ports are proved to be open we can check if the tunnel is working. Open web browser and enter http://aws_ip_or_dns_name:1234 in address line.
The screenshot below shows that the user is connected to Nginx server via AWS instance.
![Screenshot](https://github.com/irynadiudiuk/Linux_Fundamentals/blob/master/SSH_Tunneling/nginx.png) 

