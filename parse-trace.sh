#!/bin/sh
if [ "$#" -ne 1 ]; then
    echo "Please provide a trace file"
    exit 1
fi

QEMU_PATH=~/code/qemu/build
PARSER=$QEMU_PATH/scripts/simpletrace.py
OPTS=trace-events $1
PY=python

$PY $PARSER $OPTS
