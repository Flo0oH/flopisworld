#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo "🛠️  Installiere notwendige Tools..."



# Fehlende Pakete installieren
apt-get install -y apt-utils gnupg gnupg2 gnupg1 curl

echo "✅  System aktualisiert und notwendige Tools installiert."

set -e

echo "------------------------------------"
echo "🛠️  Starte Installation der Tools..."
echo "------------------------------------"

# Prüfe, ob der Befehl existiert
check_command() {
  command -v "$1" >/dev/null 2>&1
}


# 2. Docker & Docker Compose installieren
if ! check_command docker; then
  echo "🐳  Installiere Docker..."
  apt-get install -y apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
  add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
  apt-get update
  apt-get install -y docker-ce docker-ce-cli containerd.io
  systemctl enable docker
  systemctl start docker
else
  echo "🐳  Docker ist bereits installiert."
fi

if ! check_command docker-compose; then
  echo "🛠️  Installiere Docker Compose..."
  curl -L "https://github.com/docker/compose/releases/download/v2.26.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
else
  echo "🛠️  Docker Compose ist bereits installiert."
fi

# 3. kubectl installieren
if ! check_command kubectl; then
  echo "☸️  Installiere kubectl..."
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$(dpkg --print-architecture)/kubectl"
  install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  rm -f kubectl
else
  echo "☸️  kubectl ist bereits installiert."
fi

# 4. Helm installieren
if ! check_command helm; then
  echo "⎈  Installiere Helm..."
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
else
  echo "⎈  Helm ist bereits installiert."
fi

# 5. Rancher CLI installieren
if ! check_command rancher; then
  echo "🐮  Installiere Rancher CLI..."
  curl -LO https://github.com/rancher/cli/releases/download/v2.6.3/rancher-linux-amd64-v2.6.3.tar.gz
  tar -xvf rancher-linux-amd64-v2.6.3.tar.gz
  mv rancher-v2.6.3/rancher /usr/local/bin/rancher
  chmod +x /usr/local/bin/rancher
  rm -rf rancher-linux-amd64-v2.6.3.tar.gz rancher-v2.6.3
else
  echo "🐮  Rancher CLI ist bereits installiert."
fi

# 6. OpenTofu installieren
if ! check_command tofu; then
  echo "🌱  Installiere OpenTofu..."
  curl -LO https://github.com/opentofu/opentofu/releases/download/v1.6.0/tofu_v1.6.0_linux_$(dpkg --print-architecture).zip
  apt-get install -y unzip
  unzip tofu_v1.6.0_linux_*.zip
  mv tofu /usr/local/bin/tofu
  chmod +x /usr/local/bin/tofu
  rm -f tofu_v1.6.0_linux_*.zip
else
  echo "🌱  OpenTofu ist bereits installiert."
fi

# 7. Zusätzliche wichtige Tools
echo "📦  Installiere zusätzliche Tools: tree, htop, curl, jq..."
apt-get install -y tree htop curl jq git bash-completion

# 8. Konfiguration abschließen
echo "✅  Aktiviere Docker-Gruppe für den Benutzer..."
usermod -aG docker root

echo "------------------------------------"
echo "🎉  Alle Tools wurden erfolgreich installiert!"
echo "------------------------------------"

# Docker- und Systemneustart für alle Änderungen
echo "🔄  Starte Docker neu..."
systemctl restart docker

echo "✅  Installation abgeschlossen. Viel Spaß!"
