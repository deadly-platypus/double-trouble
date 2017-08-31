#!/bin/sh

echo "{\"execute\": \"qmp-capabilities\"}" | nc -U /tmp/qmp-sock
