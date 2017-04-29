FROM debian:8 AS builder

ENV VERSION v4.25-9656-rtm-2018.01.15

WORKDIR /usr/local/vpnserver


RUN apt-get update &&\
	apt-get -y -q install iptables gcc make curl

RUN curl -L http://www.softether-download.com/files/softether/${VERSION}-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-${VERSION}-linux-x64-64bit.tar.gz \
	| tar -xzv -C /usr/local/

RUN make i_read_and_agree_the_license_agreement

FROM debian:8

RUN apt-get update &&\
	apt-get -y --no-install-recommends -q install iptables &&\
	apt-get clean && \
	rm -rf /var/cache/apt/* /var/lib/apt/lists/*

WORKDIR /vpnserver

COPY --from=builder /usr/local/vpnserver /usr/local/vpnserver/

ADD docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh

VOLUME /vpnserver

EXPOSE 443/tcp 992/tcp 1194/tcp 1194/udp 5555/tcp 500/udp 4500/udp

CMD [ "server" ]

ENTRYPOINT ["/docker-entrypoint.sh"]

