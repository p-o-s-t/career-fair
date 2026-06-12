## Purpose - Career Fair Planning and Set Up
This project provides a playground environment using a device using a Linux distribution (this project used Ubuntu 24.04). It includes guided walkthroughs for enumeration, exploitation, host-based digital forensics/incident response (DFIR), and network-based DFIR. The goal is to provide prospective candidates with a hands-on look at cybersecurity roles in a controlled, non-overwhelming environment.

## Design
- **Environment:** Device using Ubuntu 24.04 (recommended, not required)
- **Architecture:** Container-centric (Docker). Scenarios run as ephemeral containers.
- **Connectivity:** Designed for offline use; images are pre-loaded locally.
- **Persistence:** Containers are non-persistent; a "Reset" returns them to a clean base state.

## Project Structure
```text
/
├── attacker_scenario_1/   # Web Enumeration & Command Injection
├── attacker_scenario_2/   # Distcc Exploit & Bind Shells
├── host_dfir_1/           # PowerShell Malware Analysis (CyberChef)
├── host_dfir_2/           # Splunk-based Investigation (BOTSv3)
├── host_dfir_3/           # Linux Log Investigation & Persistence Hunt
├── net_dfir_1/            # Traffic Analysis (Wireshark/PCAP)
├── net_dfir_2/            # Advanced Traffic Analysis
├── net_dfir_3/            # DNS Tunneling Detection & Data Exfiltration
└── detections_1/          # YARA Rules (Benign but Suspicious Binary)
```

## Walkthrough Summaries

### Attacker (Red Team)
#### Web 
1.  **Enumeration & Command Injection**
    - **Tools:** `nmap`, `curl`, web browser.
    - **Tasks:** Scan a Metasploitable target, identify a vulnerable "Network Diagnostics" tool, and exploit command injection to retrieve a hidden flag.
#### Software
1.  **Exploit Research & Bind Shells**
    - **Tools:** `nmap`, `nc`, `python3`.
    - **Tasks:** Identify the `distcc` service, exploit it using a custom Python script or Metasploit to open a persistent bind shell, and connect back to gain root access.

### DFIR (Blue Team)
#### Host
1.  **Reversing Obfuscated PowerShell**
    - **Tools:** Local CyberChef instance.
    - **Tasks:** Analyze a suspicious PowerShell script, decode multiple layers of obfuscation (Base64, Gzip, XOR), and identify the attacker's persistence mechanism.
2.  **Splunk Investigation**
    - **Tools:** Splunk Enterprise (Dockerized).
    - **Tasks:** Query the BOTSv3 dataset to trace an attacker's activities across a Windows environment, identifying infected hosts and malicious processes.
3.  **Linux Log Investigation & Persistence Hunt**
    - **Tools:** Linux CLI (shell, grep, find).
    - **Tasks:** Audit authentication logs (auth.log) for brute-force attacks, trace commands in bash history, and locate a hidden web shell and cron job persistence mechanism.

#### Network
1.  **Scenario 1: Basic Traffic Analysis**
    - **Tools:** Wireshark.
    - **Tasks:** Analyze a PCAP file to identify malicious web traffic, find successful exploits, and extract transferred files or credentials.
2.  **Scenario 2: Advanced Network Forensics**
    - **Tools:** Wireshark.
    - **Tasks:** Deep dive into a large capture file to track complex multi-stage attacks and reconstruct the attacker's network-level timeline.
3.  **Scenario 3: DNS Tunneling Detection & Data Exfiltration**
    - **Tools:** Wireshark, CyberChef.
    - **Tasks:** Analyze DNS query logs in a PCAP file, identify anomalous TXT records representing exfiltrated data, and use CyberChef to decode and reconstruct the stolen sensitive file.

#### Detections
1.  **Writing YARA Rules for Suspicious Binaries**
    - **Tools:** YARA.
    - **Tasks:** Inspect a compiled benign binary containing suspicious strings (C2 URL, registry key, custom User-Agent), identify indicators of compromise, and write a YARA rule that triggers a match on it.

## Operational Commands
Each scenario directory contains a `scenario.sh` script to manage the life cycle:
- `./scenario.sh start`: Launches the environment.
- `./scenario.sh stop`:  Shuts down the environment.
- `./scenario.sh reset`: Wipes all changes and restarts from a clean state.
