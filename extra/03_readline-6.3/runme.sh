#!/bin/bash

basepath=$(cd `dirname $0`; pwd)
tmpinstallpath=${basepath}/.tmp/

rm -rf ${tmpinstallpath}
./configure  --disable-static  --with-curses  --prefix=${tmpinstallpath}

make

make install-shared

DEST_LIB_PATH=${basepath}/../../target/x86-64/fs/
cp -rf ${tmpinstallpath}/lib  ${DEST_LIB_PATH}/


make distclean

