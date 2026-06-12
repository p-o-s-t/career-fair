import random
import os
from datetime import datetime, timedelta

# Determine target file path relative to this script's directory
script_dir = os.path.dirname(os.path.abspath(__file__))
target_file = os.path.join(script_dir, "auth.log")

legit_ip = "192.168.1.50"
attacker_ip = "192.168.1.142"
scanner_ip = "203.0.113.5"

log_entries = []

# Base time starts on Jun 10 08:00:00
current_time = datetime(2026, 6, 10, 8, 0, 0)

# 1. Generate normal background traffic for June 10 and 11
while current_time < datetime(2026, 6, 12, 2, 0, 0):
    # CRON every hour
    if current_time.minute == 0:
        log_entries.append(f"{current_time.strftime('%b %d %H:%M:%S')} compromised-server CRON[{random.randint(1000, 3000)}]: pam_unix(cron:session): session opened for user root by (uid=0)")
        log_entries.append(f"{current_time.strftime('%b %d %H:%M:%S')} compromised-server CRON[{random.randint(1000, 3000)}]: pam_unix(cron:session): session closed for user root")
    
    # Legitimate admin login once in a while (e.g. daily)
    if current_time.hour == 9 and current_time.minute == 15:
        pid = random.randint(3000, 4000)
        port = random.randint(50000, 60000)
        log_entries.append(f"{current_time.strftime('%b %d %H:%M:%S')} compromised-server sshd[{pid}]: Accepted publickey for sysadmin from {legit_ip} port {port} ssh2: RSA SHA256:abcd1234")
        log_entries.append(f"{current_time.strftime('%b %d %H:%M:%S')} compromised-server sshd[{pid}]: pam_unix(sshd:session): session opened for user sysadmin by (uid=0)")
        # Logout at 17:30
        logout_time = current_time.replace(hour=17, minute=30)
        log_entries.append(f"{logout_time.strftime('%b %d %H:%M:%S')} compromised-server sshd[{pid}]: pam_unix(sshd:session): session closed for user sysadmin")

    # Internet scanner noise (failed root attempts)
    if random.random() < 0.05:  # 5% chance per minute
        pid = random.randint(2000, 5000)
        port = random.randint(30000, 50000)
        log_entries.append(f"{current_time.strftime('%b %d %H:%M:%S')} compromised-server sshd[{pid}]: Failed password for root from {scanner_ip} port {port} ssh2")

    current_time += timedelta(minutes=5)

# 2. Attacker Brute-Force Phase starting June 12 at 02:30:00
current_time = datetime(2026, 6, 12, 2, 30, 0)
attacker_users = ["admin", "ubuntu", "guest", "user", "test", "mysql", "postgres", "oracle", "ftp", "webadmin", "operator", "root"]

attempts = 980
for i in range(attempts):
    pid = random.randint(6000, 9000)
    port = random.randint(35000, 49000)
    user = random.choice(attacker_users)
    
    current_time += timedelta(seconds=random.randint(1, 5))
    
    if user == "root":
        log_entries.append(f"{current_time.strftime('%b %d %H:%M:%S')} compromised-server sshd[{pid}]: pam_unix(sshd:auth): authentication failure; logname= uid=0 euid=0 tty=ssh ruser= rhost={attacker_ip} user=root")
        log_entries.append(f"{current_time.strftime('%b %d %H:%M:%S')} compromised-server sshd[{pid}]: Failed password for root from {attacker_ip} port {port} ssh2")
    else:
        log_entries.append(f"{current_time.strftime('%b %d %H:%M:%S')} compromised-server sshd[{pid}]: Invalid user {user} from {attacker_ip} port {port} ssh2")
        log_entries.append(f"{current_time.strftime('%b %d %H:%M:%S')} compromised-server sshd[{pid}]: pam_unix(sshd:auth): check pass; user unknown")
        log_entries.append(f"{current_time.strftime('%b %d %H:%M:%S')} compromised-server sshd[{pid}]: Failed password for invalid user {user} from {attacker_ip} port {port} ssh2")

# 3. Successful compromise login at June 12 04:15:21
current_time = datetime(2026, 6, 12, 4, 15, 21)
pid = 9102
port = 49220
log_entries.append(f"{current_time.strftime('%b %d %H:%M:%S')} compromised-server sshd[{pid}]: Accepted password for root from {attacker_ip} port {port} ssh2")
log_entries.append(f"{current_time.strftime('%b %d %H:%M:%S')} compromised-server sshd[{pid}]: pam_unix(sshd:session): session opened for user root by (uid=0)")

current_time += timedelta(minutes=2, seconds=2)
log_entries.append(f"{current_time.strftime('%b %d %H:%M:%S')} compromised-server sshd[{pid}]: pam_unix(sshd:session): session closed for user root")

# Sort entries chronologically
def parse_date(entry):
    parts = entry.split()
    date_str = f"2026 {parts[0]} {parts[1]} {parts[2]}"
    return datetime.strptime(date_str, "%Y %b %d %H:%M:%S")

log_entries.sort(key=parse_date)

# Write to target file
with open(target_file, "w") as f:
    f.write("\n".join(log_entries) + "\n")

print(f"Successfully generated {len(log_entries)} log lines in {target_file}")
