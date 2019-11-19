FROM centos:centos7

RUN yum -y update
RUN yum -y install sudo
RUN yum -y install wget
RUN yum -y install java-11-openjdk-devel

WORKDIR /opt

RUN wget https://www-us.apache.org/dist/tomcat/tomcat-9/v9.0.27/bin/apache-tomcat-9.0.27.tar.gz
RUN tar -zxf apache-tomcat-9.0.27.tar.gz
RUN useradd -ms /bin/bash -d /opt/apache-tomcat-9.0.27 tomcat
RUN chown -R tomcat:tomcat apache-tomcat-9.0.27

RUN groupadd developer
RUN groupadd admin

RUN useradd -ms /bin/bash -g developer peter
RUN useradd -ms /bin/bash -g admin bill
RUN useradd -ms /bin/bash -g developer ross

RUN usermod -a -G wheel ross

RUN echo "Cmnd_Alias TAIL_LOG = /usr/bin/tail -f /opt/apache-tomcat-9.0.27/logs/catalina.out" >> /etc/sudoers
RUN echo "Cmnd_Alias READ_LOG_VI = /usr/bin/vi /opt/apache-tomcat-9.0.27/logs/catalina.out" >> /etc/sudoers
RUN echo "Cmnd_Alias CHANGE_TO_TOMCAT = /usr/bin/su tomcat" >> /etc/sudoers

RUN echo "%developer ALL=(ALL) NOPASSWD: TAIL_LOG, READ_LOG_VI" >> /etc/sudoers
RUN echo "%admin ALL=(ALL) NOPASSWD: CHANGE_TO_TOMCAT" >> /etc/sudoers
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
