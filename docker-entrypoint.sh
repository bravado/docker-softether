#!/bin/sh


case $1 in
  server)
    [ ! -d "/var/log/vpnserver/security_log" ] && mkdir -p /var/log/vpnserver/security_log
    
    [ ! -d "/var/log/vpnserver/packet_log" ] && mkdir -p /var/log/vpnserver/packet_log
    
    [ ! -d "/var/log/vpnserver/server_log" ] && mkdir -p /var/log/vpnserver/server_log

    ln -s /var/log/vpnserver/*_log /usr/local/vpnserver/

    exec /usr/local/vpnserver/vpnserver execsvc
    ;;
  *)
    exec $@
    ;;
esac
