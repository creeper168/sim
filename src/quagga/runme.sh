#/bin/bash

[ ! -x ./configure ] && ./bootstrap.sh


[ ! -x ./configure ] && (echo "generator ./configure failed!";exit 1)

basepath=$(cd `dirname $0`; pwd)
targetpath=${basepath}/../../target/x86-64/fs/

./configure --exec-prefix=${targetpath} --disable-capabilities  --enable-user=root --enable-group=root --disable-static  --enable-vtysh

CPUS=`grep processor /proc/cpuinfo| wc -l`
make -j ${CPUS}

make install-exec

cp S99quagga  ${targetpath}/etc/init.d/ -f
chmod a+x ${targetpath}/etc/init.d/S99quagga

