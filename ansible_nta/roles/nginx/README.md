frogy.centos7-nginx
=========

A brief description of the role goes here.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

none

Role Variables
--------------

nginx_user: nginx
nginx_worker_processes: 1
nginx_error_log: /var/log/nginx/error.log
nginx_access_log: /var/log/nginx/access.log
nginx_pid: /var/run/nginx.pid
nginx_worker_connections: 1024
nginx_client_max_body_size: 8m


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
