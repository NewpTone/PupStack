#!/usr/bin/env bash 
#SwsStack.sh** is a tool to deploy complete and real OpenStack  service fast.  
  
# This script installs and configures various combinations of *Glance*,  
#*Swift*, *Horizon*, *Keystone*, *Nova*, *Mysql* and others.  
  
# yuxcer@gmail.com (Newptone)  
# Learn more and get the most recent version at http://

## 请使用root执行本脚本！
## Ubuntu 12.04 ("Precise") 部署 OpenStack Essex
## 参考：
## http://hi.baidu.com/chenshake/item/29a7b8c1b96fb82d46d5c0fb
## http://docs.openstack.org/essex/openstack-compute/starter/content/

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
        exec su -c 'sh ./FastStack.sh'
fi
#########################################################################

#install aptitude and related software
apt-get -y install aptitude
aptitude -y install puppet puppetmaster augeas-tools lvm2
aptitude -y install sqlite3 libsqlite3-ruby libactiverecord-ruby git rake
gem install puppetlabs_spec_helper
echo 'Finish Base Package Install!'
#modify Puppet.conf to enable storedconfig and configure database

augtool << EOF
set /files/etc/puppet/puppet.conf/main/storeconfigs true
set /files/etc/puppet/puppet.conf/main/dbadapter sqlite3
set /files/etc/puppet/puppet.conf/main/dblocation /var/lib/puppet/server_data/storeconfigs.sqlite
save
EOF

#add user and group for openstack
addgroup --system --gid 996 nova-volumes
addgroup --system --gid 999 kvm
addgroup --system --gid 998 libvirtd
addgroup --system --gid 997 nova
adduser --system --home /var/lib/libvirt --shell /bin/false --uid 999 --gid 999 --disabled-password libvirt-qemu
adduser --system --home /var/lib/libvirt/dnsmasq --shell /bin/false --uid 998 --gid 998 --disabled-password libvirt-dnsmasq
adduser --system --home /var/lib/nova --shell /bin/false --uid 997 --gid 997 --disabled-password nova
adduser nova libvirtd

#Download the openstack modules
cd /etc/puppet/modules
git clone git://github.com/puppetlabs/puppetlabs-openstack openstack
cd openstack
rake modules:clone


echo 'Rrepare for Deploy is finished!'


