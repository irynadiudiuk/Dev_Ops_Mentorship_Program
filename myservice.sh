#!/bin/bash

 #Description:
 #This service when started will create a file "rc2file" on rc 2.
 #When the service is stopped the file will be deleted.
 # Get function from functions library

 . /etc/init.d/functions

 FILE=rc2file
 SERVICE=$0
 RESULT=`ps -a | sed -n /${SERVICE}/p`

 if [ -f $FILE ]; then
       echo "File $FILE exists."
			   if [ "${RESULT:-null}" = null ]; then
		        echo "The process is not running" && rm -rf $FILE
			   else
				    echo "The process is running"
				 fi
 else
	    echo "File $FILE has not yet been created."
 fi

trap "rm -f $FILE && echo SIGINT; exit" 2

# Start myservice
  start() {
  echo "$FILE is created" | tee /home/$USER/$FILE
  }

# Status of myservice
  status() {
  if [ "${RESULT:-null}" = null ]; then
     echo "The process is not running"
  else
	   echo "The process is running"
  fi
  }

# Stop  myservice
  stop() {
	    rm -f /home/$USER/$FILE && echo "$FILE was deleted"
  }
# Restart myservice
  restart() {
	if [ -f $FILE ]; then
	         echo "The process will be restarted" && echo "$FILE was deleted" && rm -f /home/$USER/$FILE && echo "$FILE is created" | tee /home/$USER/$FILE
  else
	   echo "The process will be restarted" && echo "$FILE is created" tee /home/$USER/$FILE
	fi
	}

### main logic ###
case "$1" in
  start)
  	start
	     ;;
  stop)
	  stop
		   ;;
  status)
    status
       ;;
  restart)
       ;;
  *)
  echo $"Usage: $0 {start|stop|status|restart}"
																																			        exit 1
																																						esac
																																						  exit 0










