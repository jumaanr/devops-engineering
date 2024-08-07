#!/bin/bash

# ---- Go Application ---- #

#project : https://github.com/kodekloudhub/go-webapp-sample?tab=readme-ov-file
sudo docker run -it -p 8080:8000 --name go-webapp-sample -v /home/azureuser/go-webapp-sample:/go/go-webapp-sample golang
go run main.go
http://40.121.246.11:8080/#/home
http://40.121.246.11:8080/swagger/index.html
# tests are available in controller directory
cd ./controller/
go test -v . #run every single test inside of the controller directory

#admin,Adm!n321 : https://8090-port-4e653ce0415e49fa.labs.kodekloud.com/  mike , M!k3@123

#? --- Jenkings CLI --- #
# ref : https://www.jenkins.io/doc/book/managing/cli/#ssh
# jenkins -> me -> configre --> SSH PublicKeys (put your generated public key) --> Save

curl -Lv http://localhost:8085/login 2>&1 | grep -i 'x-ssh-endpoint' #shows the port jenkins used
ssh -i /home/mike/.ssh/jenkins_key -l mike -p 8022 jenkins-server help

# some examples using Jenkins CLI
java -jar jenkins-cli.jar -s http://localhost:8085 -auth 'admin:Adm!n321'
# list all the installed plugins
list-plugins
# install plugin from file, URL, update center
install-plugin
#CLI options can we use to uninstall a Jenkins plugin
#disable a Jenkins plugin/ same as uninstall
disable-plugin

java -jar jenkins-cli.jar -s http://localhost:8085 -auth 'admin:Adm!n321' install-plugin cloudbees-bitbucket-branch-source:877.vb_b_d5243f6794
java -jar jenkins-cli.jar -s http://localhost:8085 -auth 'admin:Adm!n321' list-plugins

#update 
java -jar jenkins-cli.jar -s http://localhost:8085 -auth 'admin:Adm!n321' disable-plugin github -restart -r

# api token also can be created and provided to access cli

#? ---- Jenkins Plugins --- #
# Jenkins plugins allow you to connect from one service to another in Jenkins
# Can get information about plugins : https://plugins.jenkins.io/
# locally plugins can be installed from here : http://172.210.115.13:8080/manage/pluginManager/
#--- If a certain plugin requires a Jenkis reboot
sudo systemctl restart jenkins 
# or
service jenkins restart

# if this Jenkins deployment is a docker container
docker restart ContainerID

# plugin allows to perform RBAC
# plugin allows to perform Project Based Matrix Access

