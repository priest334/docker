#!/bin/bash

set -x
if ! id -u nginx >/dev/null 2>&1; then
        useradd -s /sbin/nologin -M nginx
fi
mkdir -p /var/log/nginx && chown -R nginx:nginx /var/log/nginx
mkdir -p /var/lib/nginx/tmp && chown -R nginx:nginx /var/lib/nginx

ROOTDIR=/yumrepo/7

if [ ! -d "$ROOTDIR" ]; then
	mkdir -p "$ROOTDIR"
fi

process_is_running() {
        ret=$(pgrep -x $1)
        if [ ! -n "$ret" ]; then
                return 1
        fi
        return 0
}

start() {
	yum makecache fast
	while true; do
		if ! process_is_running nginx; then
			createrepo $ROOTDIR
                	nginx
		fi
        	sleep 1
	done
}

if [ -z "$*" ]; then
	start
else
	exec $*
fi


