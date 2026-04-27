## Purpose - Career Fair Planning and Set Up
This project provides a playground environment across three specialized Ubuntu laptops. It includes guided walkthroughs for enumeration, exploitation, host-based digital forensics/incident response (DFIR), and network-based DFIR. The goal is to provide prospective candidates with a hands-on look at cybersecurity roles in a controlled, non-overwhelming environment.

## Design
- **Environment:** 3 separate laptops running Ubuntu 24.04 LTS.
- **Architecture:** Container-centric (Docker). Scenarios run as ephemeral containers.
- **Connectivity:** Designed for air-gapped use; images are pre-loaded locally.
- **Persistence:** Containers are non-persistent; a "Reset" returns them to a clean base state.

## Project Structure
```text
/
├── attacker/           # Laptop 1: Red Team / Offensive Scenarios
│   ├── attacker_scenario_1/   # Web Enumeration & Command Injection
│   └── attacker_scenario_2/   # Distcc Exploit & Bind Shells
├── host_dfir/          # Laptop 2: Host Forensics Scenarios
│   ├── host_scenario_1/       # PowerShell Malware Analysis (CyberChef)
│   └── host_scenario_2/       # Splunk-based Investigation (BOTSv3)
└── network_dfir/       # Laptop 3: Network Forensics Scenarios
    ├── network_scenario_1/    # Traffic Analysis (Wireshark/PCAP)
    └── network_scenario_2/    # Advanced Traffic Analysis
```

## Walkthrough Summaries

### Laptop 1: Attacker (Red Team)
1.  **Scenario 1: Web Enumeration & Command Injection**
    - **Tools:** `nmap`, `curl`, Browser.
    - **Tasks:** Scan a Metasploitable target, identify a vulnerable "Network Diagnostics" tool, and exploit command injection to retrieve a hidden flag.
2.  **Scenario 2: Exploit Research & Bind Shells**
    - **Tools:** `nmap`, `msfconsole`, `nc`, Python.
    - **Tasks:** Identify the `distcc` service, exploit it using a custom Python script or Metasploit to open a persistent bind shell, and connect back to gain root access.

### Laptop 2: Host DFIR (Blue Team)
1.  **Scenario 1: Reversing Obfuscated PowerShell**
    - **Tools:** Local CyberChef instance.
    - **Tasks:** Analyze a suspicious PowerShell script, decode multiple layers of obfuscation (Base64, Gzip, XOR), and identify the attacker's persistence mechanism.
2.  **Scenario 2: Splunk Investigation**
    - **Tools:** Splunk Enterprise (Dockerized).
    - **Tasks:** Query the BOTSv3 dataset to trace an attacker's activities across a Windows environment, identifying infected hosts and malicious processes.

### Laptop 3: Network DFIR (Blue Team)
1.  **Scenario 1: Basic Traffic Analysis**
    - **Tools:** Wireshark.
    - **Tasks:** Analyze a PCAP file to identify malicious web traffic, find successful exploits, and extract transferred files or credentials.
2.  **Scenario 2: Advanced Network Forensics**
    - **Tools:** Wireshark, `tshark`.
    - **Tasks:** Deep dive into a large capture file to track complex multi-stage attacks and reconstruct the attacker's network-level timeline.

## Operational Commands
Each scenario directory contains a `scenarioX.sh` script to manage the lifecycle:
- `./scenarioX.sh start`: Launches the environment.
- `./scenarioX.sh stop`: Shuts down the environment.
- `./scenarioX.sh reset`: Wipes all changes and restarts from a clean state.
