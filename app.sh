
!/usr/bin/bash

input=/home/8/forapps/client_names.txt

cat ${input} | while read str
 do

  os=`echo "$str" | cut -f1`
  client=`echo "$str"|cut -f2 |cut -d"/" -f2- | sed -e 's/\//_/g'`


  #echo $client
  #echo $os
  #echo "----------"

  case ${os} in
        "Windows"*) echo "Windows System" >> system_names
        if [ ! -d /8/etc/8-apps/inputs_$client ]; then
          mkdir /home/8/forapps/inputs_$client
          echo "created a new directory -- inputs_$client" >> created_app_list
          cp -R /home/ne2282421/forapps/windows_template_app/* /home/8/forapps/inputs_$client
        else
          echo "inputs_${client} already exists" >> already_existed_apps
read
        fi
        ;;
        "AIX"*) echo "AIX" >> system_names
        if [ ! -d /splunk/etc/8-apps/inputs_$client ]; then
          mkdir /home/8/8/inputs_$client
          echo "created a new directory -- inputs_$client" >> created_app_list
          cp -R /home/8/forapps/aix_solaris_template_app/* /home/8/forapps/inputs_$client
        else
          echo "inputs_${client} already exists" >> already_existed_apps
read
        fi
        ;;
        "Solaris"*) echo "Solaris" >> system_names
        if [ ! -d /splunk/etc/deployment-apps/inputs_$client ]; then
          mkdir /home/8/forapps/inputs_$client
          echo "created a new directory -- inputs_$client" >> created_app_list
          cp -R /home/8/forapps/aix_solaris_template_app/* /home/8/forapps/inputs_$client
        else
          echo "inputs_${client} already exists" >> already_existed_apps
read
        fi
        ;;
        RHEL*) echo "RHEL" >> system_names
        if [ ! -d /splunk/etc/deployment-apps/inputs_$client ]; then
          mkdir /home/8/forapps/inputs_$client
          echo "created a new directory -- inputs_$client" >> created_app_list
          cp -R /home/8/forapps/linux_template_app/* /home/8/forapps/inputs_$client
        else
          echo "inputs_${client} already exists" >> already_existed_apps
read
        fi
        ;;
        CentOS.Linux*) echo "CentoOS.Linux" >> system_names
        if [ ! -d /splunk/etc/deployment-apps/inputs_$client ]; then
          mkdir /home/8/forapps/inputs_$client
          echo "created a new directory -- inputs_$client" >> created_app_list
          cp -R /home/8/forapps/linux_template_app/* /home/8/forapps/inputs_$client
        else
          echo "inputs_${client} already exists" >> already_existed_apps
read
        fi
        ;;
        Cent.OS*) echo "Cent.OS" >> system_names
        if [ ! -d /splunk/etc/deployment-apps/inputs_$client ]; then
          mkdir /home/8/forapps/inputs_$client
          echo "created a new directory -- inputs_$client" >> created_app_list
          cp -R /home/8/forapps/linux_template_app/* /home/8/forapps/inputs_$client
        else
          echo "inputs_${client} already exists" >> already_existed_apps
read
        fi
        ;;
        ZOS*) echo "ZOS" >> system_names ;;
        Ubuntu*) echo "Ubuntu" >> system_names ;;
        Linux*) echo "Linux" >> system_names
        if [ ! -d /splunk/etc/deployment-apps/inputs_$client ]; then
          mkdir /home/8/forapps/inputs_$client
          echo "created a new directory -- inputs_$client" >> created_app_list
          cp -R /home/8/forapps/linux_template_app/* /home/8/forapps/inputs_$client
        else
          echo "inputs_${client} already exists" >> already_existed_apps
read
        fi
        ;;
        *) echo "unknown OS" ;;


  esac
  done
  
  s
