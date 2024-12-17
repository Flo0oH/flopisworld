# Dockerfile: master
FROM ubuntu:20.04

# Installiere benötigte Pakete
RUN apt-get update && apt-get install -y \
    openssh-server \
    ansible \
    vim \
    iputils-ping \
    python3 \
    sudo

# SSH konfigurieren
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Port 22 für SSH öffnen
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
