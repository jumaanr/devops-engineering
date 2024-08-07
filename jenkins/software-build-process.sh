#!/bin/bash

#? ------ Software Build Process ----#

#TODO ------------- [Java ]---------------- #

# -- Installation --#

# berfore version 8 : ver 1.8 , then version onwards 9.0 , 10.0, 11.0 came like that
# jdk - java development kid - set of tools to build , develop , run in the system
# begore version 9 : JDK and JRE shipped seperately , from ver9 onwards  both packaged as single JDK 
# develop : jdb (debugger), javadoc(documentation)  Build: javac , jar (archive code with libraries)  Run: JRE ( need to run java application on any system) , java (java commandline tools)
# all above are located in /bin/ directory
ls jdk-13.0.2/bin/

#download binaries from https://www.oracle.com/ae/java/technologies/downloads/
wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz
tar -xvf openjdk-13.0.2_linux-x64_bin.tar.gz
/opt/jdk-13/bin/java -version # this will be extracted with all binary files
jdk-13.0.2/bin/java -version # check if java is installed
#* defaul path will be one of each
/usr/bin/java #or
/usr/lib/jvm

update-alternatives --list # check where its installed

# Adding Path Variable
# for single user it will be on ~./bashrc or ~/.profile based on linux distribution
vi  ~/.bashrc  , vir ~/.profile
export PATH=$PATH:/path/to/java/bin # add following line
source ~/.bashrc or source ~/.profile
# export/update $PATH variable to all users (shell specific)
sudo vi /etc/profile
export PATH=$PATH:/path/to/java/bin
# export/update $PATH variable to all users (non-shell specific)
sudo vi /etc/environment
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/path/to/java/bin" #Modify the PATH line to include your Java bin directory.
# reboot the system to make changes effect system-wide

#--- Lab Examples
/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el7_7.x86_64/jre/bin/java -version
sudo tar -xvzf jdk-20.0.2_linux-x64_bin.tar.gz
export PATH=$PATH:/opt/jdk-20.0.2/bin
javadoc MyClass.java /opt/app/doc/ # building a javadoc file

sudo yum install ant # install ant
/opt/ant/build.xml # located here
cd /opt/ant
ant compile jar  #moves the jar file to /opt/ant/dist dir
ant # ant to carry out all steps specified in the build configuration file /opt/ant/build.xml

sudo yum install maven
/opt/maven #located here
/opt/maven/my-app/pom.xml # source location
#compile package
cd /opt/maven/my-app/; sudo mvn package
java -cp /opt/maven/my-app/target/my-app-1.0-SNAPSHOT.jar com.mycompany.app.App #-cp class search path of directories and zip/jar files

# --- Java Build Process ---#
javac myclass.java
java myclass # you dont specify .class extension here
# Human Readable Source Code -- [Compiler] --> Intermediate Byte Code -- [JVM] --> Machine Readable Code # java can be run anywhere , because JRE creates a JVM

# Package JAR - Java Archive , WAR -Web Archive (Include web content)
jar cf myapp.jar MyClass.class Service.class ... # create a jar, pass list of classfiles , it creates a manifest file contains information abotu the package such as entrypoint (which class should start first when someone should run this package)
java -jar Myapp.jar
# Documentation
javadoc -d doc MyClass.java # HTML version of documentation of code
# Build Process : Develop -> Compile-> Package -> Documentation 
# Different developers are working on same project this process gets complex
# Build Tools Helps to automate these : Maven, Gradle , ANT

# ANT: build.xml contains , describe the build process in seperate section in XML file
ant compile jar
# Maven : pom.xml contains , 
cd <directorycontainsjavasourcecode>
mvnw clean install
# Gradle : build.gradle contains
./gradlew build
./gradlew run







# ---- Javascript ---- #

# ---- Python ---- #