#!/usr/bin/env bash

# the first is backup original yum folder to the .bak 
sudo cp /etc/yum.repos.d /etc/yum.repos.d.bak

# download the aliyun yum resource
sudo wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

# clean cache of the old yum resource
sudo yum clean all

# reestablishment yum resource
sudo yum makecache
