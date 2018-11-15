#based on hermsi/alpine-sshd
FROM alpine:edge
RUN apk update && apk upgrade && apk add --no-cache curl p7zip
WORKDIR /root
COPY shx.sh /root
RUN chmod +x /root/shx.sh

ENV ROOT_PASSWORD dockerssh

RUN apk update && apk upgrade && apk add --no-cache mc openssh \
	&& sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
	&& echo "root:${ROOT_PASSWORD}" | chpasswd \
	&& rm -rf /var/cache/apk/* /tmp/*

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 22
EXPOSE 17000-17999

ENTRYPOINT ["/entrypoint.sh"]

