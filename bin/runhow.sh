#!/bin/bash
set -e

## Simple script that attemts to show the command used to start a
## server running on a given port.

shopt -s nocasematch

while getopts p:h opt; do
    case $opt in
        p)
            PORT=$OPTARG
            ;;
        h)
            NEED_HELP=1
            ;;
    esac
done

if [[ -z $PORT ]]; then
    NEED_HELP=1
fi

if [[ "$NEED_HELP" = "1" ]]; then
    echo "Usage $0 -p port"
    exit 1
fi

PID=`netstat -nlp | grep $PORT | awk '{print $(NF)}' | sed -e 's:/.*::'`

if [[ "$PID" = "" ]]; then
    exit 2
fi

ps -eo pid,cmd | grep $PID | cut -d ' ' -f2-
