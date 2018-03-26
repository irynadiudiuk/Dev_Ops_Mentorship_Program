## Nginx as Reverse Proxy for Apache and Tomcat servers 

- Requires Ansible 2.7 or newer
- Expects CentOS/RHEL 7.x hosts


This playbook deploys a very basic implementation of Nginx Web Server in a role of a reverse proxy for Apache and Tomcat application servers,

To use this playbook we first create environment using Vargant 2.0.1. When it is created you will see that three instances are cretaed in a private network with the following ip addresses:
1. nginx - 192.168.60.4
2. apache - 192.168.60.5
3. tomcat - 192.168.60.6

Each of these instances belongs of a group with the same name that is defined in the inventory file.


To run the playbook, use the following command in the root directory of the project:

	ansible-playbook -i inventory site.yml

When the playbook run completes, you should be able to see that Nginx server (192.168.60.4) on port 8001 re-directs to Apache Tomcat. When typing port 8002 you will be re-directed to Apache HTTP Server.

