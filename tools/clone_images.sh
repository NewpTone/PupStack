#!/usr/bin/sh

#Ubuntu 12.04
wget http://uec-images.ubuntu.com/precise/current/precise-server-cloudimg-amd64-disk1.img
glance  image-create --name 'Ubuntu 12.04 x64' --disk-format qcow2 --container-format ovf --is-public true < precise-server-cloudimg-amd64-disk1.img

#Fedora
glance  image-create --name 'Fedora 16 x64' --disk-format qcow2 --container-format ovf --is-public true < f16-x86_64-openstack-sda.qcow2

#Cirros
wget -c https://launchpad.net/cirros/trunk/0.3.0/+download/cirros-0.3.0-x86_64-disk.img
glance image-create --name cirros-0.3.0-x86_64 --disk-format qcow2 --container-format bare --is-public true < cirros.img
