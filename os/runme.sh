#!/bin/bash

set -e 

V=${V:-0}
[ "$V" != "0" ] && set -x

ARCH=${ARCH:-x86-64}
CPUS=`grep processor /proc/cpuinfo| wc -l`

basepath=$(cd `dirname $0`; pwd)

INSTALL_PATH=${basepath}/../target/${ARCH}/


if [ ! -f ./kernel/.config ] && (! diff -q  ${basepath}/configs/dot.config.${ARCH} ./kernel/.config); then
	echo "New build!"
	make -C ./kernel mrproper
	cp ${basepath}/configs/dot.config.${ARCH} ./kernel/.config -f
else
	echo "Continue build!"
fi

echo "Build kernel and modules\n"
make -j ${CPUS} -C ./kernel V=$V

echo "install modules to " ${INSTALL_MOD_PATH}
make -C./kernel modules_install INSTALL_MOD_PATH=${INSTALL_PATH}/fs V=$V

if [ "${ARCH}" == "x86-64" ]; then
	cp ${basepath}/kernel/arch/x86/boot/bzImage ${INSTALL_PATH}/iso/linux
fi



