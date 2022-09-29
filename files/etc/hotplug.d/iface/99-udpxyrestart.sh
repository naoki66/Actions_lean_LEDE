#!/bin/sh

if [ "$INTERFACE" = "pppoe-wan" ] && [ "$ACTION" = "ifup" -o "$ACTION" == "ifupdate" ]
then
    /etc/init.d/udpxy restart
fi
