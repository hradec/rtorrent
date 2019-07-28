#!/bin/bash

CD=$(dirname $(readlink -f $BASH_SOURCE))

libtorrent() {
	cd $CD/libtorrent.git
	./build.sh
}

rtorrent() {
	cd $CD
	[ ! -e ./configure ] && ./autogen.sh
	./configure CXXFLAGS='-fPIC -std=gnu++11' PKG_CONFIG_PATH=/usr/lib/pkgconfig --prefix=/usr --with-ncurses --with-xmlrpc-c && \
	make install -j 32
}

echo -e -n "Building libtorrent...\t"
libtorrent > ./libtorrent_build.log 2>&1 && echo "[ OK ]" || echo "[FAIL]"
echo -e -n "Building rtorrent...\t"
rtorrent > ./rtorrent_build.log 2>&1 && echo "[ OK ]" || echo "[FAIL]"


