#!/bin/bash

CURRENT_DIR=`pwd`
TOOLCHAINS=$CURRENT_DIR/toolchain-mipsel_3.3.6_BRCM24/bin
GLIB_DIR=$CURRENT_DIR/mipsel-linux/glib
TARGET_DIR=$CURRENT_DIR/dd-wrt.v24_std_generic

echo $CURRENT_DIR
echo $TOOLCHAINS
echo $GLIB_DIR
echo $TARGET_DIR

PATH=$TOOLCHAINS:$PATH

cd NoCatSplash-0.92
make clean
./configure --target=mipsel-linux --host=mipsel-linux --build=mipsel-linux --disable-shared --enable-static --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --libexecdir=/usr/lib --sysconfdir=/etc --datadir=/usr/share --localstatedir=/var --mandir=/usr/man --infodir=/usr/info --with-mode=open --with-remote-splash --with-firewall=iptables --with-docroot=/www --disable-glibtest --with-glib-prefix=$GLIB_DIR
make CC=mipsel-linux-uclibc-gcc LD=mipsel-linux-uclibc-ld CFLAGS="-I$GLIB_DIR/include -DHAVE_LIBGHTTP -g -O2" LIBS="-static -L$GLIB_DIR/lib -lglib -lghttp"
/usr/bin/install -c -v -s --strip-program=$TOOLCHAINS/mipsel-linux-uclibc-strip src/splashd $TARGET_DIR/rootfs/usr/sbin/splashd
cd ..

