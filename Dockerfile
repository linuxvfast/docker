#sshd image version
#Version 0.1

#set base image
FROM ubuntu:16.04

#auther
MAINTAINER from vfast

#change install sources
#cp /etc/apt/sources.list /etc/apt/sources.list.default
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial main" > /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial main" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial universe" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial universe" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-updates universe" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates universe" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-security main" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-security universe" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security universe" >> /etc/apt/sources.list

#install sshd service
RUN apt-get update &&\
    apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh
RUN mkdir  /script

#delete pam limit
RUN sed -ir 's/account    required     pam_nologin.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd

#copy localhost file to the remote host
ADD authorized_keys /root/.ssh/authorized_keys
ADD run.sh /script/run.sh
RUN chmod +x /script/run.sh

#export port
EXPOSE 22

#auto start sshd
CMD ["/script/run.sh"]
