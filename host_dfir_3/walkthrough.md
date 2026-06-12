# Host DFIR Scenario 3: Linux Log Investigation & Persistence Hunt

## Background
A Linux-based web server hosting critical infrastructure was compromised. Security alerts indicated unusual network traffic originating from the machine. As a Security Analyst, you are tasked with conducting live forensics on the compromised server to understand how the attacker gained access, what actions they performed, and how they established persistence.

## Objectives
1. Identify the attacker's IP address and the brute-forced user accounts.
2. Determine the time and target of the successful compromise.
3. Investigate the actions taken by the attacker after gaining access, including secondary infrastructure identified.
4. Locate and analyze the obfuscated persistence mechanism.

## Walkthrough

### Step 1: Start the Scenario and Connect
1. Ensure the scenario is running:
   ```bash
   ./host_dfir_3/scenario.sh start
   ```
2. Gain access to the server's shell to perform your investigation:
   ```bash
   docker exec -it host_dfir_3_target /bin/bash
   ```

### Step 2: Analyze Authentication Logs
1. Examine the authentication logs at `/var/log/auth.log` to investigate the initial access:
   ```bash
   cat /var/log/auth.log
   ```
   *Tip: Since there are thousands of entries in this log, use `grep` to filter for common authentication keywords like `Failed` or `Accepted`.*
2. Answer the following questions:
   - What IP address was brute-forcing the SSH service?
   - What user accounts did the attacker attempt to brute force?
   - Which account was successfully compromised, and at what timestamp?

### Step 3: Audit Attacker Commands (Command History)
1. Check the command history of the root user to trace what the attacker did once inside:
   ```bash
   cat /root/.bash_history
   ```
2. Review the command history to answer:
   - What directory did the attacker navigate to first?
   - What file did they create in the web directory, and what does it do?
   - The attacker downloaded a script. What is the URL of the download source, and where was the file saved locally? (Notice the IP address used to host the download!)

### Step 4: Hunt for Persistence (Payload Analysis)
1. In Step 3, you saw that the attacker scheduled a cron job. Let's inspect the cron configuration file they created:
   ```bash
   cat /etc/cron.d/php-session-cleanup
   ```
2. Now, inspect the script that is being executed by the cron job:
   ```bash
   cat /dev/shm/.systemd-login
   ```
3. Answer the following questions:
   - What type of payload is stored inside `/dev/shm/.systemd-login`?
   - What IP address and port does the payload attempt to connect back to? (Is this different from the SSH brute-force source IP?)

## Cleanup
Once you have documented all findings, exit the container shell (`exit`) and stop the environment:
```bash
./host_dfir_3/scenario.sh stop
```
