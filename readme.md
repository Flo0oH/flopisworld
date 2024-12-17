
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
