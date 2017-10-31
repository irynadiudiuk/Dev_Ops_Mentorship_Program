Process Management in Linux

Plan:

1. Types of processes and basic concepts;
2. Ways of creating a process;
3. Signals in process management;
4. Priority of the processes;
5. Resources.
_________________________________



*Types of Processes*

Depending on the way the process is started there are two types of processes in Linux:

*Foreground processes* (interactive processes) – these are initialized and controlled through a terminal session. In other words, there has to be a user connected to the system to start such processes; they haven’t started automatically as part of the system functions/services.
*Background processes* (automatic processes) – are processes not connected to a terminal; they do not expect any user input.


There are different types of processes running on a system from the perspecive of their state, some of them are:

*Child processes* - a process that is created by some other process during run-time. 
Usually child processes are created to execute some binary from within an existing process. 
Child processes are created using fork() system call.
Normally process are made to run through shell/terminal. 
In that case the shell becomes the parent and the executed process becomes the child process. 
On Unix/Linux each process has a parent except the init process.

*Daemon Processes* - these are special processes run in background. 
They are system related processes that are not associated with terminal. 
These processes run will root permissions and usually provide services to processes. 
A typical example would be a mail daemon that waits for the arrival of e-mails and notifies the user when an e-mail is received.

*Orphan processes* - a process creates a child process (as described above) and when the parent process terminates, the child processes becomes an orphan and is then taken over by the init process. 
Though the init process takes the ownership of the orphan process, it is still called an orphan as its original parent no longer exists.

*Zombie process* - when a child process gets terminated or completes its execution, an entry in the process table remains until the parent process fetches the status information of the terminated child. 
Until then the terminated process enters zombie state and is known as zombie process.  
When a process is terminated, all the memory and resources associated with the process are released but the entry still exists in the process table.
A signal SIGCHILD is send to the parent of the process (that just terminated). 
Typically, the handler of this signal in the parent executes a ‘wait’ call that fetches the exit status of the terminated process and then the entry of this zombie process from the process table is also removed.


_________________________________
*Resources*

https://www.youtube.com/watch?v=0XdjODvsRN8&list=PLtK75qxsQaMLZSo7KL-PmiRarU7hrpnwK&index=17
https://unix.stackexchange.com/questions/115495/how-to-find-out-in-which-order-etc-init-d-scripts-are-load-on-debian
https://www.cs.auckland.ac.nz/references/unix/digital/AQTLLATE/DOCU_002.HTM
http://www.tldp.org/LDP/intro-linux/html/sect_04_02.html
https://shabirimam.wordpress.com/2009/03/10/adding-script-to-run-at-startup-or-shutdown/
