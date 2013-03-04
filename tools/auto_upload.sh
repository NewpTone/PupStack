set -e

#source openrc

#You should change the url 
wget http://10.67.21.30/uec-images/ubuntu/12.04/ubuntu-12.04-uec-amd64.tar.gz
mkdir ubuntu  && tar -zxvf ubuntu-12.04-uec-amd64.tar.gz
cd ubuntu
echo 'Start Upload Images Ubuntu'
glance add name="Ubuntu12.04_x64-kernel" disk_format=aki container_format=aki < precise-server-cloudimg-amd64-vmlinuz-virtual
glance add name="Ubuntu12.04_x64-ramdisk" disk_format=ari container_format=ari < precise-server-cloudimg-amd64-loader
kernel_id=`glance index | grep 'Ubuntu12.04_x64-kernel' | head -1 |  awk -F' ' '{print $1}'`
ram_id=`glance index | grep 'Ubuntu12.04_x64-ramdisk' | head -1 |  awk -F' ' '{print $1}'`
glance add name="Ubuntu12.04_x64" kernel_id=${kernel_id} ramdisk_id=${ram_id} disk_format=ami container_format=ami < precise-server-cloudimg-amd64.img
glance index


# CentOS
tar -zxvf  uec-centos6.2_x64.tar.gz && cd centos6.2_x64 
echo 'Start Upload Images CentOS'
glance add name="CentOS6.2-kernel" disk_format=aki container_format=aki is_public=true < vmlinuz-2.6.32
glance add name="CentOS6.2-ramdisk" disk_format=ari container_format=ari is_public=true < initrd
kernel_id=`glance index | grep 'CentOS6.2-kernel' | head -1 |  awk -F' ' '{print $1}'`
ram_id=`glance index | grep 'CentOS6.2-ramdisk' | head -1 |  awk -F' ' '{print $1}'`
glance add name="Centos 6.2" kernel_id=${kernel_id} ramdisk_id=${ram_id} disk_format=ami container_format=ami is_public=true < centos6.2_x64.img

