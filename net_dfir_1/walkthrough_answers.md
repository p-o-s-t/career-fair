# Remcos RAT Analysis - Answer Key

## Objective 1: Suspicious DNS Queries
- **Malicious Domains Identified:**
    - `retrypoti.top` (Initial redirection/ClickFix infrastructure)
    - `forcebiturg.com` (Malware delivery domain)
    - `heatingoilstoragetanks.com` (Likely compromised site used in the chain)
- **Explanation:** These domains are used to host the initial "ClickFix" script or the malware payloads themselves. `retrypoti.top` is a common top-level domain for short-lived malicious sites.

## Objective 2: C2 Server Identification
- **C2 IP Address:** `193.178.170.155`
- **C2 Port:** `443` (TCP)
- **C2 Protocol:** TLS/SSL (The Remcos traffic is wrapped in encryption to evade detection).
- **Other Indicators:** Repeated persistent connections to this IP address after the initial file downloads.

## Objective 3: Initial Delivery ("ClickFix")
- **Malicious URL/File:**
    - `http://forcebiturg.com/boot`
    - `http://forcebiturg.com/proc`
- **Mechanism:** The "ClickFix" technique typically prompts the user to "Fix" a problem by running a command (which is actually a PowerShell or similar script). This script then reaches out to `forcebiturg.com` to download the final Remcos RAT payload.
- **Traffic Evidence:** HTTP GET requests to `forcebiturg.com` followed by large data transfers and subsequent C2 activity to `193.178.170.155`.

## Summary of IOCs
| Type | Value |
|------|-------|
| Domain | `retrypoti.top` |
| Domain | `forcebiturg.com` |
| IP (C2) | `193.178.170.155` |
| URL | `hxxp[://]forcebiturg.com/boot` |
| URL | `hxxp[://]forcebiturg.com/proc` |
