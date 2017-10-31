Process Management in Linux

Plan:

1. Creation of a Process; 
2. Types of Processes;
3. States of Processes; 
3. Signals in Process Management;
4. Priority of Processes;
5. Resources.
_________________________________


***Creation a Process***

A new process is created when an existing process makes an exact copy of itself. This child process has the same environment as its parent, only the process ID number is different. This procedure is called forking.

After the forking process, the address space of the child process is overwritten with the new process data. This is done through an exec call to the system.

The fork-and-exec mechanism thus switches an old command with a new, while the environment in which the new program is executed remains the same, including configuration of input and output devices, environment variables and priority. This mechanism is used to create all UNIX processes, so it also applies to the Linux operating system. Even the first process, init, with process ID 1, is forked during the boot procedure in the so-called bootstrapping procedure.


_________________________________
***Types of Processes***

Depending on the way the process is started there are two types of processes in Linux:

**Foreground processes** (interactive processes) – these are initialized and controlled through a terminal session. In other words, there has to be a user connected to the system to start such processes; they haven’t started automatically as part of the system functions/services.
**Background processes** (automatic processes) – are processes not connected to a terminal; they do not expect any user input.


There are other types of processes running on a system:

**Child process** - a process that is created by some other process during run-time. 
Usually child processes are created to execute some binary from within an existing process. 
Child processes are created using fork() system call.
Normally process are made to run through shell/terminal. 
In that case the shell becomes the parent and the executed process becomes the child process. 
On Unix/Linux each process has a parent except the init process.

**Daemon Process** - this is a special type of process that runs in background. 
They are system related processes that are not associated with terminal. 
These processes run will root permissions and usually provide services to processes. 
A typical example would be a mail daemon that waits for the arrival of e-mails and notifies the user when an e-mail is received.

**Orphan process** - a process creates a child process (as described above) and when the parent process terminates, the child processes becomes an orphan and is then taken over by the init process. 
Though the init process takes the ownership of the orphan process, it is still called an orphan as its original parent no longer exists.

**Zombie process** - when a child process gets terminated or completes its execution, an entry in the process table remains until the parent process fetches the status information of the terminated child. 
Until then the terminated process enters zombie state and is known as zombie process.  
When a process is terminated, all the memory and resources associated with the process are released but the entry still exists in the process table.
A signal SIGCHILD is send to the parent of the process (that just terminated). 
Typically, the handler of this signal in the parent executes a ‘wait’ call that fetches the exit status of the terminated process and then the entry of this zombie process from the process table is also removed.

_________________________________

***States of Processes***

During execution, a process changes from one state to another depending on its environment/circumstances. In Linux, a process has the following possible states:

**Running** – here it’s either running (it is the current process in the system) or it’s ready to run (it’s waiting to be assigned to one of the CPUs).
**Waiting** – in this state, a process is waiting for an event to occur or for a system resource. Additionally, the kernel also differentiates between two types of waiting processes; interruptible waiting processes – can be interrupted by signals and uninterruptible waiting processes – are waiting directly on hardware conditions and cannot be interrupted by any event/signal.
**Stopped** – in this state, a process has been stopped, usually by receiving a signal. For instance, a process that is being debugged.

________________________________

 ***Signals in process management***
 
 The fundamental way of controlling processes in Linux is by sending signals to them. There are multiple signals that can  be sent to a process, to view all the signals run: ```kill -l```
 
 To send a signal to a process, commands ```kill```, ```pkill``` or ```pgrep``` can be used. But programs can only respond to signals if they are programmed to recognize those signals.

And most signals are for internal use by the system, or for programmers when they write code. The following are signals which are useful to a system user:

SIGHUP 1 – sent to a process when its controlling terminal is closed.
SIGINT 2 – sent to a process by its controlling terminal when a user interrupts the process by pressing  [Ctrl+C].
SIGQUIT 3 – sent to a process if the user sends a quit signal [Ctrl+D].
SIGKILL 9 – this signal immediately terminates (kills) a process and the process will not perform any clean-up operations.
SIGTERM 15 – this a program termination signal (kill will send this by default).
SIGTSTP 20 – sent to a process by its controlling terminal to request it to stop (terminal stop); initiated by the user pressing ```[Ctrl+Z]```.
________________________________

***Priority of Processes***

On the Linux system, all active processes have a priority and certain nice value. 
Processes with higher priority will normally get more CPU time than lower priority processes.
However, a system user with root privileges can influence this with the nice and renice commands.

In the output of the top command, the NI value shows the process prioruty (nice).

This ```nice``` command is used to set a nice value for a process. Users can attribute a nice value from 0 to 20 to processes they own.
Only the root user can use negative nice values (-20 for highest priority and 20 for lowest).

To renice the priority of a process, ```renice``` command is used.

_________________________________
*Resources*

http://www.linuxtopia.org/online_books/introduction_to_linux/linux_Process_creation.html
http://www.thegeekstuff.com/2012/02/unix-process-overview/
https://www.tecmint.com/linux-process-management/
