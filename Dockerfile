ARG SSHD_BASE_IMAGE=alpine

FROM $SSHD_BASE_IMAGE
ARG SSHD_ALLOW_PORT_FORWARD=no
COPY sshd_config /etc/ssh/sshd_config.d/vagrant
RUN apk add --no-cache openssh bash sudo && \
    adduser -D vagrant && \
    sed -i '/vagrant/s/:!:/:\*:/' /etc/shadow && \
    install -d -m 0700 -o vagrant /home/vagrant/.ssh && \
    install -m 0700 -o vagrant <(echo ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN1YdxBpNlzxDqfJyw/QKow1F+wvG9hXGoqiysfJOn5Y vagrant insecure public key) /home/vagrant/.ssh/authorized_keys && \
    echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant && \
    sed -i -e "/^#*AllowTcpForwarding .*/{s//AllowTcpForwarding $SSHD_ALLOW_PORT_FORWARD/;:a;n;ba;q}" -e "\$aAllowTcpForwarding $SSHD_ALLOW_PORT_FORWARD" /etc/ssh/sshd_config
WORKDIR /home/vagrant
EXPOSE 22/tcp
CMD ssh-keygen -A && /usr/sbin/sshd -D -e

