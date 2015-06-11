#!/bin/bash
#set -x

EXTRA=0
KERNEL=0

compile_kernel(){
	pushd os
	sh ./runme.sh
	popd
}

compile_extra(){
	pwd
	for i in $(ls extra)
	do
		echo build $i
		pushd ./extra/$i
		sh ./runme.sh
		popd
	done
}


while test $# -gt 0; do
case "$1" in
	--with-extra)
		EXTRA=1
		shift
	;;
	--with-kernel)
		KERNEL=1
		shift
	;;

	*)
		echo Unkown paramenter!
		exit 1
	;;
esac
done

[ "${EXTRA}" == "1" ] && compile_extra
[ "${KERNEL}" == "1" ] && compile_kernel
