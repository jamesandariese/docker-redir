#!/bin/sh

help() {
    echo "redir [ip port]"
    echo
    echo "if started with no arguments, this will attempt to redirect"
    echo "all exposed ports from the linked containers"
    echo
    echo "this is not compatible with UDP"
}

if [ x-h = x"$1" ];then
    help
    exit 0
fi

if [ x = x"$2" ];then
    if [ x != x"$1" ];then
        help
        exit 1
    fi
    env | grep -oE _PORT_[0-9]+_TCP=.* | cut -d/ -f3 | while read L; do
        echo "redirecting ${L#*:} to ${L%:*}:${L#*:}"
        nc -ll -p ${L#*:} -e /usr/bin/nc ${L%:*} ${L#*:} &
    done
    # wait doesn't seem to be reliable here... quite odd.
    # doesn't really matter for docker though.
    while sleep 6000;do true;done
else
    echo "redirecting $2 to $1:$2"
    nc -ll -p "$2" -e /usr/bin/nc "$1" "$2"
fi
