#based on vongola12324/alpine-sshd
FROM alpine:edge

ENV ROOT_PASSWORD dockerssh

RUN apk add --no-cache \
    ca-certificates \
    curl \
    openssh \
    openssh-sftp-server \
    curl \
    p7zip
    
# Remove exist keys
RUN rm -rf /etc/ssh/ssh_host_*

# Regenerate SSH Host Keys
RUN ssh-keygen -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

COPY sshd_config /etc/ssh/sshd_config

WORKDIR /root
COPY shx.sh /root

# SET root password as ROOT_PASSWORD
RUN echo "root:${ROOT_PASSWORD}" | chpasswd

EXPOSE 22
EXPOSE 17000-17999

CMD ["/usr/sbin/sshd", "-D"]


