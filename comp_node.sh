#!/usr/bin/env bash 
#pres_stack.sh  to install basic package service fast.  
  
# This script installs the basic packages.
  
# yuxcer@gmail.com (Newptone)  
# Learn more and get the most recent version at http://

## 请使用root执行本脚本！
## Ubuntu 12.04 ("Precise") 部署 OpenStack Essex

## 一：准备系统
## 1：下载ubuntu 12.04. 服务器版本
## http://mirrors.ustc.edu.cn/ubuntu-releases/12.04/ubuntu-12.04-server-amd64.iso
## 2：安装OS
## 最小化安装，只需要安装ssh server就可以。
## 装完系统后 更新源里的包,更新系统。确保你装的是最新版本的包。

## 3：设置root权限
## 为了简单，全部都是用root来运行。 
if [ `whoami` != "root" ]; then
        sudo -s
        exec su -c 'sh ./pres_stack.sh'
fi
#########################################################################

#install apt-get and related software
apt-get update
apt-get -y install puppet 
echo 'Finish Base Package Install!'
#modify Puppet.conf to enable storedconfig and configure database

echo '[agent]' >> /etc/puppet/puppet.conf

augtool << EOF

set /files/etc/puppet/puppet.conf/agent/server puppet.master.com
set /files/etc/puppet/puppet.conf/agent/certname openstack_controller
set /files/etc/puppet/puppet.conf/agent/report true
set /files/etc/puppet/puppet.conf/agent/pluginsync true
save
EOF

#add user and group for openstack
addgroup --system --gid 996 nova-volumes

echo 'Rrepare for Deploy is finished!'


