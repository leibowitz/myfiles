#!/bin/bash
IP=`ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'`
echo $IP
