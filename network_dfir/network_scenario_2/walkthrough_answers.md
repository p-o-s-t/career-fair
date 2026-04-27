# Scenario 2: IcedID Analysis - Answer Key (Unit 42 "Cold as Ice")

## Objective 1: Initial Redirect
- **Redirector IP:** `80.77.25.175`
- **Filename:** `main.php`
- **Method:** HTTP GET request.
- **Findings:** The request contained a suspicious double Host header, which is a common evasion technique for IcedID/BokBot.

## Objective 2: Victim & Malicious Download
- **Internal IP (Victim):** `10.4.19.136`
- **Victim Hostname:** `DESKTOP-SFF9LJF`
- **Victim MAC Address:** `14:58:d0:2e:c5:ae`
- **Malicious File:** `Scan_Inv.zip` (hosted on `firebasestorage.googleapis.com`)

## Objective 3: C2 Server Identification (BackConnect)
- **C2 IP Address:** `193.149.176.100`
- **C2 Port:** `443` (TCP)
- **Traffic Pattern:** Persistent, encrypted "BackConnect" traffic used by IcedID for remote command execution.

## Summary of IOCs
| Type | Value |
|------|-------|
| IP (Redirector) | `80.77.25.175` |
| IP (Victim) | `10.4.19.136` |
| IP (BackConnect C2) | `193.149.176.100` |
| File Name | `Scan_Inv.zip` |
| Hostname | `DESKTOP-SFF9LJF` |
