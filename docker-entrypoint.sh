#!/bin/sh


case $1 in
  server)

    ln -sf /app/vpn_server.config /usr/local/vpnserver

    for i in security_log packet_log server_log backup.vpn_server.config; do
      [ ! -d "/app/${i}" ] && mkdir -p "/app/${i}"
      ln -s /app/${i} /usr/local/vpnserver/
    done

    exec /usr/local/vpnserver/vpnserver execsvc
    ;;
  *)
    exec $@
    ;;
esac
