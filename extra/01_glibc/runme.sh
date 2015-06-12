#!/bin/bash

#set -x

basepath=$(cd `dirname $0`; pwd)

buildpath=$(dirname $basepath)/glibc_build
echo $basepath $buidlpath

if [ "${basepath}" != "${buildpath}" ] ; then
	rm -rf ${buildpath}
	mkdir -p ${buildpath}
	cp -p $0 ${buildpath}/
	pushd ${buildpath}
	. ./$0 $*
	popd
	rm -rf ${buildpath}
	exit $?
fi

export CFLAGS="-g -O2"
../01_glibc/configure  --enable-add-ons  --disable-sanity-checks  --libdir=/lib


CPUS=`grep processor /proc/cpuinfo| wc -l`

make -j ${CPUS} 

#install needed libs

DEST_LIB_PATH=${basepath}/../../target/x86-64/fs/lib
[ ! -d ${DEST_LIB_PATH} ] && mkdir -p ${DEST_LIB_PATH}
[ ! -L ${DEST_LIB_PATH}64 ] && ln -s ./lib ${DEST_LIB_PATH}64

cp -f ./elf/ld-linux-x86-64.so.2 	${DEST_LIB_PATH}/
cp -f ./libc.so.6 			${DEST_LIB_PATH}/
cp -f ./math/libm.so.6 			${DEST_LIB_PATH}/
cp -f ./nptl/libpthread.so.0 		${DEST_LIB_PATH}/
cp -f ./login/libutil.so.1 		${DEST_LIB_PATH}/
cp -f ./dlfcn/libdl.so.2		${DEST_LIB_PATH}/
cp -f ./rt/librt.so.1			${DEST_LIB_PATH}/
cp -f ./crypt/libcrypt.so.1		${DEST_LIB_PATH}/
cp -f ./resolv/libresolv.so.2 		${DEST_LIB_PATH}/
cp -f ./nis/libnss_compat.so.2		${DEST_LIB_PATH}/
cp -f ./nss/libnss_files.so.2 		${DEST_LIB_PATH}/


#./elf/ld-linux-x86-64.so.2
#./libc.so.6
#./resolv/libanl.so.1
#./resolv/libresolv.so.2
#./resolv/libnss_dns.so.2
#./nss/libnss_files.so.2
#./nss/libnss_db.so.2
#./rt/librt.so.1
#./libidn/libcidn.so.1
#./nptl_db/libthread_db.so.1
#./hesiod/libnss_hesiod.so.2
#./nis/libnsl.so.1
#./nis/libnss_nis.so.2
#./nis/libnss_nisplus.so.2
#./nis/libnss_compat.so.2
#./math/libm.so.6
#./dlfcn/libdl.so.2
#./locale/libBrokenLocale.so.1
#./login/libutil.so.1
#./crypt/libcrypt.so.1
#./nptl/libpthread.so.0

