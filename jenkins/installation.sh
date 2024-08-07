#?--- Starting with Jenkins --- #

#ref : https://www.jenkins.io/
# installation : https://www.jenkins.io/doc/book/installing/linux/
# As docker container : https://hub.docker.com/r/jenkins/jenkins/ , https://github.com/jenkinsci/docker/blob/master/README.md

#--- Normal installation : CentOS ---#
# Jenkins Installation - Official Documentation --

sudo yum install epel-release -y
sudo yum install java-11-openjdk -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo --no-check-certificate
sudo rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install jenkins -y


# Edit /lib/systemd/system/jenkins.service file and change Jenkins port to 8090 by updating Environment="JENKINS_PORT=" variable value.
sudo vi /lib/systemd/system/jenkins.service
Environment="JENKINS_PORT=8090"
sudo systemctl start jenkins

/var/lib/jenkins/secrets/initialAdminPassword #password located at


systemctl daemon-reload # apply changes in systemd unti files 
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins


# Add exceptions in Firewall
YOURPORT=8080
PERM="--permanent"
SERV="$PERM --service=jenkins"

firewall-cmd $PERM --new-service=jenkins
firewall-cmd $SERV --set-short="Jenkins ports"
firewall-cmd $SERV --set-description="Jenkins port exceptions"
firewall-cmd $SERV --add-port=$YOURPORT/tcp
firewall-cmd $PERM --add-service=jenkins
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --reload

## -- Install Jenkins on Docker Container ---#
#!/bin/bash
# https://hub.docker.com/r/jenkins/jenkins
sudo docker pull jenkins/jenkins
sudo docker run -d -p 8090:8080 -p 50000:50000 -v /home/azureuser/jenkins_home:/var/jenkins_home jenkins/jenkins
mkdir jenkins_home
chmod 777 jenkins_home #since jenkins user with uid 1000 accessing
sudo docker ps
sudo docker exec -it b51107794522 /bin/bash

# ------- Debian Ubuntu Installation -----------------#
# allow following firewall ports, ensure following ports are exposed in NSG
sudo ufw status
sudo ufw allow 8080/tcp
sudo ufw allow 50000/tcp
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
sudo ufw status



