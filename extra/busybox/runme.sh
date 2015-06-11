#!/bin/bash

basepath=$(cd `dirname $0`; pwd)
CPUS=`grep processor /proc/cpuinfo| wc -l`

cp ./configs/NOS_x86-64_config .config

make  -j ${CPUS} 

make install

