FROM centos:centos7

RUN yum -y update
RUN yum -y install sudo
RUN yum -y install wget
RUN yum -y install java-11-openjdk-devel
WORKDIR /opt
RUN wget https://www-us.apache.org/dist/tomcat/tomcat-9/v9.0.27/bin/apache-tomcat-9.0.27.tar.gz
RUN tar -zxf apache-tomcat-9.0.27.tar.gz
RUN useradd -ms /bin/bash tomcat
RUN chown -R tomcat:tomcat apache-tomcat-9.0.27
RUN useradd -ms /bin/bash developer
RUN useradd -ms /bin/bash admin

RUN echo "User_Alias TOMCAT_ADMINS = admin" >> /etc/sudoers
RUN echo "User_Alias TOMCAT_USER = developer" >> /etc/sudoers
RUN echo "Cmnd_Alias TOMCAT_RESTART = /opt/apache-tomcat-9.0.27/bin/startup.sh,/opt/apache-tomcat-9.0.27/bin/shutdown.sh" >> /etc/sudoers
RUN echo "admin ALL=(ALL) NOPASSWD: /usr/bin/su tomcat" >> /etc/sudoers
RUN echo "developer ALL=(ALL) NOPASSWD: TOMCAT_RESTART" >> /etc/sudoers
