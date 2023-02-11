#!/bin/bash

# Author: DAKAlba 
# Date: Feb. 11th 2023

#--------------Description-----------------
# This script when executed will download and install Jenkins on the system. 

#---------Since Jenkins is a Java application,
# we first need to install Java on our system.
# To do that, run the command: (make sure it is complete!):

#----------Step 1: Java installation---------------------------

sudo yum install java-11-openjdk-devel -y

if 
 [ $? -ne 0 ]

then

 echo "Java installation not succesful"
 exit 1

 fi 

#--------------------Step 2: Enable The Jenkins Repository-------------------
#-----------Here we are going to add the Jenkins repositories so that we can use yum to install the latest version of Jenkins. To do this run the commands below.------------

curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo

if 
  [ $? -ne 0 ]

  then 

  echo "url link not established"
  exit 2

  fi 


  sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

if 
  [ $? -ne 0 ]
  
then 
   echo "url link not established"
   exit 3

fi

#---------Step 3: Install the latest stable version of Jenkins------------------

sudo yum install jenkins -y

if 
  [ $? -ne 0 ]

then 

   echo "Jenkins Installation was unsuccessful"
   exit 4 

fi 


#--------------After installation, the status of Jenkins will be checked--------------

sudo systemctl status jenkins

if 
  [ $? -ne 0 ]
then 
   echo "system was unable to check the status of Jenkins"
   exit 5

fi 

#--------------------------If Jenkins is not active, enable Jenkins service to start on system boot---------------------

sudo systemctl enable jenkins

if 
  [ $? -ne 0]

then 
   echo "system was unable to enable Jenkins Service"
   exit 6
fi 


#-----------------Step 4: Adjusting Firewall----------------------------------------------------
#-----------------At this level we are going to open the necessary port for Jenkins--------------

sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp

if 
   [ $? -ne 0] 

then 

echo "port 8080 not opened for Jenkins service"
exit 7

fi 

#---------------we need to reload------------------

sudo firewall-cmd --reload

if 
  [ $? -ne 0]

then 
   echo "firewall was unable to reload"
   exit 8
fi

#-------------------Final step--------------------------------
#-------------------After setting up Jenkins on the server, you will need an administrator password to unlock Jenkins----------------------------
#------this command will display the administrator password that was generated during the installation of Jenkins: it will assit in  unlocking Jenkins on the server--------

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

if 
   [ $? -ne 0 ]

then 
    echo "unable to display initialAdiminPassword"
    exit 9
fi 


