#!/bin/bash

basepath=$(cd `dirname $0`; pwd)
CPUS=`grep processor /proc/cpuinfo| wc -l`

cp ./configs/NOS_x86-64_config .config

make  -j ${CPUS} 

make install


prefix=$(grep CONFIG_PREFIX .config | awk -F\" '{print $2}')
etcpath=${prefix}/etc/


mkdir -p ${etcpath}
#users,groups,inittab
cp -prf ./etc/* ${etcpath}/  

make distclean


