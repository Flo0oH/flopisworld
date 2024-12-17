
# **Linux Cluster Simulation mit Docker**

Dieses Projekt simuliert eine kleine Linux-Umgebung mit einem **Master**-Container (Ubuntu) und 4 **Slave-Containern** (OpenSUSE). Zusätzlich wird **Portainer** als zentrales Verwaltungstool bereitgestellt.

## **Inhaltsverzeichnis**

1. [Voraussetzungen](#1-voraussetzungen)  
2. [Projekt starten](#2-projekt-starten)  
3. [Portainer-Verwaltung](#3-portainer-verwaltung)  
4. [SSH-Verbindungen](#4-ssh-verbindungen)  
5. [IP-Adressen abrufen](#5-ip-adressen-abrufen)  
6. [Container stoppen](#6-container-stoppen)

---

## **1. Voraussetzungen**

- **Docker** und **Docker-Compose** müssen installiert sein.  
- Ein **SSH-Client** wie `ssh` (Linux/Mac/WSL) oder **Putty** (Windows) ist erforderlich.

---

## **2. Projekt starten**

### **Schritt 1: Docker-Umgebung starten**

Führe den folgenden Befehl aus:

```bash
docker-compose up -d
```

### **Schritt 2: Überprüfen, ob alle Container laufen**

```bash
docker ps
```

---

## **3. Portainer-Verwaltung**

Portainer läuft als zentrales Verwaltungstool und ist über den Browser zugänglich.

### **URL:**

```
http://localhost:9000
```

### **Erster Login:**

- **Benutzername**: `admin`  
- **Passwort**: `admin`

---

## **4. SSH-Verbindungen**

### **Übersicht der SSH-Zugangsdaten**

| **Container** | **Hostname** | **SSH-Port** | **Benutzer** | **Passwort** |
|---------------|--------------|--------------|--------------|--------------|
| **Master**    | master       | 2222         | root         | root         |
| **Pi1**       | pi1          | 2223         | root         | root         |
| **Pi2**       | pi2          | 2224         | root         | root         |
| **Pi3**       | pi3          | 2225         | root         | root         |
| **Pi4**       | pi4          | 2226         | root         | root         |

---

### **SSH-Verbindung herstellen**

#### **Mit SSH (Linux/Mac/WSL):**

```bash
ssh root@localhost -p 2222  # Master
ssh root@localhost -p 2223  # Pi1
ssh root@localhost -p 2224  # Pi2
ssh root@localhost -p 2225  # Pi3
ssh root@localhost -p 2226  # Pi4
```

#### **Mit Putty (Windows):**

1. **Host**: `localhost`  
2. **Port**:  
   - Master: `2222`  
   - Pi1: `2223`  
   - Pi2: `2224`  
   - Pi3: `2225`  
   - Pi4: `2226`  
3. **Benutzer**: `root`  
4. **Passwort**: `root`

---

## **5. IP-Adressen abrufen**

Um die IP-Adressen der Container innerhalb des Docker-Netzwerks zu sehen, führe folgenden Befehl aus:

```bash
docker inspect -f '{{.Name}} - {{.NetworkSettings.Networks.my_network.IPAddress}}' $(docker ps -q)
```

### **Beispielausgabe:**

```
/master - 172.18.0.2
/pi1 - 172.18.0.3
/pi2 - 172.18.0.4
/pi3 - 172.18.0.5
/pi4 - 172.18.0.6
/portainer - 172.18.0.7
```

---

## **6. Container stoppen**

Um alle Container zu stoppen und die Umgebung herunterzufahren:

```bash
docker-compose down
```

---

## **Zusammenfassung**

- **Portainer**: Zugriff unter `http://localhost:9000` (admin/admin)  
- **SSH**:
   - Master: `ssh root@localhost -p 2222`  
   - Pi1: `ssh root@localhost -p 2223`  
   - Pi2: `ssh root@localhost -p 2224`  
   - Pi3: `ssh root@localhost -p 2225`  
   - Pi4: `ssh root@localhost -p 2226`  
- **IP-Adressen**: Mit `docker inspect` abrufbar.

---

### Viel Spaß beim Arbeiten mit deinem Linux-Cluster! 🚀

## output demo

root@master:/srv/00_Raspi_Master_Dev/flopisworld/03_ansible_rollout# ansible-playbook -i hosts update-playbook.yml

PLAY [Update all Pi servers] ***************************************************************

TASK [Gathering Facts] *********************************************************************
ok: [pi2]
ok: [pi4]
ok: [pi3]
ok: [pi1]

TASK [Copy the update script to the Pi servers] ********************************************
ok: [pi1]
changed: [pi4]
changed: [pi3]
changed: [pi2]

TASK [Execute the update script] ***********************************************************
changed: [pi1]
changed: [pi2]
changed: [pi3]
changed: [pi4]

TASK [Display the update output] ***********************************************************
ok: [pi1] => {
    "msg": "Starting system update...\nHit:1 http://deb.debian.org/debian bullseye InRelease\nHit:2 http://deb.debian.org/debian-security bullseye-security InRelease\nHit:3 http://deb.debian.org/debian bullseye-updates InRelease\nReading package lists...\nReading package lists...\nBuilding dependency tree...\nReading state information...\nCalculating upgrade...\n0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.\nReading package lists...\nBuilding dependency tree...\nReading state information...\ntree is already the newest version (1.8.0-1).\n0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.\nSystem update baseline complete!"
}
ok: [pi2] => {
    "msg": "Starting system update...\nHit:1 http://deb.debian.org/debian bullseye InRelease\nHit:2 http://deb.debian.org/debian-security bullseye-security InRelease\nHit:3 http://deb.debian.org/debian bullseye-updates InRelease\nReading package lists...\nReading package lists...\nBuilding dependency tree...\nReading state information...\nCalculating upgrade...\n0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.\nReading package lists...\nBuilding dependency tree...\nReading state information...\nThe following NEW packages will be installed:\n  tree\n0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.\nNeed to get 48.2 kB of archives.\nAfter this operation, 117 kB of additional disk space will be used.\nGet:1 http://deb.debian.org/debian bullseye/main arm64 tree arm64 1.8.0-1 [48.2 kB]\nFetched 48.2 kB in 0s (115 kB/s)\nSelecting previously unselected package tree.\r\n(Reading database ... \r(Reading database ... 5%\r(Reading database ... 10%\r(Reading database ... 15%\r(Reading database ... 20%\r(Reading database ... 25%\r(Reading database ... 30%\r(Reading database ... 35%\r(Reading database ... 40%\r(Reading database ... 45%\r(Reading database ... 50%\r(Reading database ... 55%\r(Reading database ... 60%\r(Reading database ... 65%\r(Reading database ... 70%\r(Reading database ... 75%\r(Reading database ... 80%\r(Reading database ... 85%\r(Reading database ... 90%\r(Reading database ... 95%\r(Reading database ... 100%\r(Reading database ... 12371 files and directories currently installed.)\r\nPreparing to unpack .../tree_1.8.0-1_arm64.deb ...\r\nUnpacking tree (1.8.0-1) ...\r\nSetting up tree (1.8.0-1) ...\r\nSystem update baseline complete!"
}
ok: [pi3] => {
    "msg": "Starting system update...\nHit:1 http://deb.debian.org/debian bullseye InRelease\nHit:2 http://deb.debian.org/debian-security bullseye-security InRelease\nHit:3 http://deb.debian.org/debian bullseye-updates InRelease\nReading package lists...\nReading package lists...\nBuilding dependency tree...\nReading state information...\nCalculating upgrade...\n0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.\nReading package lists...\nBuilding dependency tree...\nReading state information...\nThe following NEW packages will be installed:\n  tree\n0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.\nNeed to get 48.2 kB of archives.\nAfter this operation, 117 kB of additional disk space will be used.\nGet:1 http://deb.debian.org/debian bullseye/main arm64 tree arm64 1.8.0-1 [48.2 kB]\nFetched 48.2 kB in 0s (132 kB/s)\nSelecting previously unselected package tree.\r\n(Reading database ... \r(Reading database ... 5%\r(Reading database ... 10%\r(Reading database ... 15%\r(Reading database ... 20%\r(Reading database ... 25%\r(Reading database ... 30%\r(Reading database ... 35%\r(Reading database ... 40%\r(Reading database ... 45%\r(Reading database ... 50%\r(Reading database ... 55%\r(Reading database ... 60%\r(Reading database ... 65%\r(Reading database ... 70%\r(Reading database ... 75%\r(Reading database ... 80%\r(Reading database ... 85%\r(Reading database ... 90%\r(Reading database ... 95%\r(Reading database ... 100%\r(Reading database ... 12371 files and directories currently installed.)\r\nPreparing to unpack .../tree_1.8.0-1_arm64.deb ...\r\nUnpacking tree (1.8.0-1) ...\r\nSetting up tree (1.8.0-1) ...\r\nSystem update baseline complete!"
}
ok: [pi4] => {
    "msg": "Starting system update...\nHit:1 http://deb.debian.org/debian bullseye InRelease\nHit:2 http://deb.debian.org/debian-security bullseye-security InRelease\nHit:3 http://deb.debian.org/debian bullseye-updates InRelease\nReading package lists...\nReading package lists...\nBuilding dependency tree...\nReading state information...\nCalculating upgrade...\n0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.\nReading package lists...\nBuilding dependency tree...\nReading state information...\nThe following NEW packages will be installed:\n  tree\n0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.\nNeed to get 48.2 kB of archives.\nAfter this operation, 117 kB of additional disk space will be used.\nGet:1 http://deb.debian.org/debian bullseye/main arm64 tree arm64 1.8.0-1 [48.2 kB]\nFetched 48.2 kB in 0s (146 kB/s)\nSelecting previously unselected package tree.\r\n(Reading database ... \r(Reading database ... 5%\r(Reading database ... 10%\r(Reading database ... 15%\r(Reading database ... 20%\r(Reading database ... 25%\r(Reading database ... 30%\r(Reading database ... 35%\r(Reading database ... 40%\r(Reading database ... 45%\r(Reading database ... 50%\r(Reading database ... 55%\r(Reading database ... 60%\r(Reading database ... 65%\r(Reading database ... 70%\r(Reading database ... 75%\r(Reading database ... 80%\r(Reading database ... 85%\r(Reading database ... 90%\r(Reading database ... 95%\r(Reading database ... 100%\r(Reading database ... 12371 files and directories currently installed.)\r\nPreparing to unpack .../tree_1.8.0-1_arm64.deb ...\r\nUnpacking tree (1.8.0-1) ...\r\nSetting up tree (1.8.0-1) ...\r\nSystem update baseline complete!"
}

PLAY RECAP *********************************************************************************
pi1                        : ok=4    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
pi2                        : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
pi3                        : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
pi4                        : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

