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
        exec su -c 'sh ./pres_stacklab.sh'
fi
#########################################################################

#install aptitude and related software
apt-get -y install aptitude
aptitude -y install puppet augeas-tools
aptitude -y install sqlite3 libsqlite3-ruby libactiverecord-ruby git rake
gem install puppetlabs_spec_helper
echo 'Finish Base Package Install!'
#modify Puppet.conf to enable storedconfig and configure database

echo '[agent]' >> /etc/puppet/puppet.conf

augtool << EOF

set /files/etc/puppet/puppet.conf/agent/server sws-yz-10.master.com
set /files/etc/puppet/puppet.conf/agent/report true
set /files/etc/puppet/puppet.conf/agent/pluginsync true
set /files/etc/puppet/puppet.conf/agent/listen true
set /files/etc/puppet/puppet.conf/agent/environment folsom


save
EOF

#
cp pre_setup.pp /etc/puppet/manifests
#Download the openstack modules

cd /etc/puppet/modules
git clone git://github.com/NewpTone/puppetlabs-ntp.git ntp
git clone git://github.com/puppetlabs/puppetlabs-apt  apt 


puppet apply /etc/puppet/manifests/pre_setup.pp --debug
echo 'Rrepare for Deploy is finished!'


