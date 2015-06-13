#!/bin/bash

basepath=$(cd `dirname $0`; pwd)
tmpinstallpath=${basepath}/.tmp/

rm -rf ${tmpinstallpath}
./configure --disable-static  --with-shared --with-termlib -prefix=${tmpinstallpath}

CPUS=`grep processor /proc/cpuinfo| wc -l`
make -j ${CPUS}

make install

DEST_LIB_PATH=${basepath}/../../target/x86-64/fs/
cp -df ${tmpinstallpath}/lib/*.so*  ${DEST_LIB_PATH}/lib/






