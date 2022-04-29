#!/bin/bash

if ! id -u nginx >/dev/null 2>&1; then
        useradd -s /sbin/nologin -M nginx
fi
mkdir -p /var/log/nginx && chown -R nginx:nginx /var/log/nginx
mkdir -p /var/lib/nginx/tmp && chown -R nginx:nginx /var/lib/nginx

ROOTDIR=/usr/share/nginx/html/7

process_is_running() {
        ret=$(pgrep -x $1)
        if [ ! -n "$ret" ]; then
                return 1
        fi
        return 0
}

trap "exit" SIGINT
start() {
	yum makecache
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
	case "$1" in
		"download")
			shift 1
			download $@
			;;
		?)
			exec "$@"
			;;
	esac
fi


