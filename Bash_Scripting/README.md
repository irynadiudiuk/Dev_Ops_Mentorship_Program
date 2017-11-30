#!/bin/bash

 # Description:
 # This service when started will create a file "rc2file" and start infinite loop.
 # When the service is stopped the file will be deleted.
 # When script is called with status parameter, it is checked if the process is running.
 # Get function from functions library

 . /etc/init.d/functions

 FILE=rc2file
 RESULT=`ps -ef | grep -v grep | grep $0 | wc -l`
 SERVICE=myservice

# Start myservice
  start() {
# The interrupt signal will be trapped
  trap "" 2
  if [ -f $FILE ]; then
     echo "File $FILE exists." &&  ps -ef | grep -v grep | grep $SERVICE
         if [ `( ps -ef | grep -v grep | grep $SERVICE | wc -l)` > 1 ] ; then
          echo "The process is running no need to create $FILE"
         else
           echo "The process is not running. The file will be deleted and re-created" && `rm -f $FILE`\
           echo "$FILE created" | tee /home/$USER/$FILE
         fi
  else
     echo "$FILE is created" | tee /home/$USER/$FILE
  fi
# infinite loop

 while true
 do
    echo "hello"
    sleep 2
 done
          }
# Status of myservice
  status() {
  /usr/bin/ps -aux | /usr/bin/grep [m]yservice
  if [ $? -ne 0 ]; then
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
    $0 stop
    $0 start
            }



### Main logic ###
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
