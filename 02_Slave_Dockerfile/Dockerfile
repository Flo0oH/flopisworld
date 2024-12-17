# Dockerfile: pi_simulation
FROM --platform=linux/arm64 arm64v8/debian:bullseye

RUN apt-get update && apt-get install -y openssh-server sudo && \
    mkdir /var/run/sshd && \
    echo 'root:raspberry' | chpasswd && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

RUN ssh-keygen -A
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
