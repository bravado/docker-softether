#!/bin/sh


case $1 in
  server)

    ln -s /vpnserver/vpn_server.config /usr/local/vpnserver

    for i in security packet server; do
      [ ! -d "/vpnserver/${i}_log" ] && mkdir -p "/vpnserver/${i}_log"
      ln -s /var/log/vpnserver/${i}_log /usr/local/vpnserver/
    done

    exec /usr/local/vpnserver/vpnserver execsvc
    ;;
  *)
    exec $@
    ;;
esac
