#based on hermsi/alpine-sshd
FROM nggy/alpine-run

ENV ROOT_PASSWORD alpinessh

RUN apk update && apk upgrade && apk add --no-cache mc openssh \
	&& sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
	&& echo "root:${ROOT_PASSWORD}" | chpasswd \
	&& rm -rf /var/cache/apk/* /tmp/*

COPY entrypoint.sh /usr/local/bin/

EXPOSE 2200

ENTRYPOINT ["entrypoint.sh"]

