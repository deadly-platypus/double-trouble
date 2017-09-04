#!/bin/sh

awk -f awk-find-same-read.txt < "${1:-/dev/stdin}"
