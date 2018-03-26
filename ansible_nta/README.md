## Nginx as Reverse Proxy for Apache and Tomcat servers 

- Requires Ansible 2.7 or newer
- Expects CentOS/RHEL 7.x hosts


This playbook deploy a very basic implementation of Nginx Web Server in a role of a reverse proxy for Apache and Tomcat application servers,

To use this playbook we first create environment using Vargant 2.0.1.
Our environment consists of thee instances:
1. nginx - 192.168.60.4
2. apache - 192.168.60.5
3. tomcat - 192.168.60.6

Each of these instances belong of a group with the same name that is defined in the inventory file created in root directoryof the project.


To run the playbook, use the following command:

	ansible-playbook -i hosts site.yml

When the playbook run completes, you should be able to see that Nginx server (192.168.60.4) on port 8001 redirects to Apache Tomcat while typing port 8002 you will be re-directed to Apache HTTP Server.

