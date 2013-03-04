#!/usr/bin/env bash 
  
# This script installs the basic packages and deploy node for Stacklab.
# Author: Yu Xingchao  
# Email: yuxcer@gmail.com (Newptone)  

## 系统
## 1：下载ubuntu 12.04. 服务器版本
## http://mirrors.ustc.edu.cn/ubuntu-releases/12.04/ubuntu-12.04-server-amd64.iso
## 2. 额外组件
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
apt-get -y install puppet augeas-tools
apt-get -y install libsqlite3-ruby libactiverecord-ruby git rake
gem install puppetlabs_spec_helper
echo 'Finish Base Package Install!'


#modify Puppet.conf to enable storedconfig and configure database
echo '[agent]' >> /etc/puppet/puppet.conf

augtool << EOF

set /files/etc/puppet/puppet.conf/agent/server center.stacklab.org
set /files/etc/puppet/puppet.conf/agent/report true
set /files/etc/puppet/puppet.conf/agent/pluginsync true
set /files/etc/puppet/puppet.conf/agent/listen true
set /files/etc/puppet/puppet.conf/agent/environment folsom

save
EOF

cp pre_setup_scut.pp /etc/puppet/manifests

#Download the openstack modules
cd /etc/puppet/modules
git clone git://github.com/NewpTone/puppetlabs-ntp.git ntp
git clone git://github.com/puppetlabs/puppetlabs-apt  apt 
git clone git://github.com/puppetlabs/puppetlabs-stdlib stdlib

puppet apply /etc/puppet/manifests/pre_setup_scut.pp --debug
echo 'Rrepare for Deploy is finished!'

echo 'Try to retrieve catalog from Puppet Master.....'

puppet agent -vt --waitforcert 60 --verbose 






