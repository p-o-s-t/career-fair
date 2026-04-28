# Scenario 2: IcedID Malware Analysis (Unit 42 Quiz)

## Background
An Active Directory environment has been targeted by a malware campaign. You are tasked with analyzing the packet capture from the infected network. Your goal is to identify the source of the infection, the specific workstation compromised, and the attacker's persistent Command & Control (C2) infrastructure.

## Objectives
1. Identify the IP address and filename of the initial IcedID payload.
2. Determine the Hostname, IP address, and MAC address of the infected workstation.
3. Identify the primary IP address used for persistent C2/BackConnect communication.

## Guided Walkthrough

### Step 1: Access the Analysis Environment
1. Open a web browser on the host machine.
2. Navigate to `http://localhost:3002`. 
3. You will see a desktop environment containing **Wireshark**.

### Step 2: Open the PCAP
In the Wireshark application (inside the browser), go to **File > Open** and navigate to the following path:
`/data/scenario_2.pcap`

### Step 3: Identify the Initial Redirect
Attackers often use a "redirector" to send victims to the final malware hosting site.
- **Filter:** `http.request.uri contains "main.php"`
- **Analysis:** 
    1. Locate the packet showing the GET request to `80.77.25.175`.
    2. **Right-click** that packet and select **Follow > HTTP Stream**.
- **What you see:** A new window will open showing the full conversation. Notice the **Location** field in the server's response pointing to a `.zip` file on Google Firebase.
- **The "Why":** "Following the stream" allows a forensic analyst to see exactly what the user saw and how the server responded, revealing the next step in the attack chain.

### Step 4: Identify the Victim & Malicious Download
Once you see where the redirect points, you can identify the file being downloaded and the computer that requested it.
- **Filter:** `http.request.uri contains "Scan_Inv.zip"`
- **Analysis:** 
    1. Identify the **Source IP** address that requested the file. This is your victim.
    2. Click on the packet, and in the **Packet Details** pane (middle), expand the **Ethernet II** section to find the **Source MAC Address**.
    3. Change your filter to `nbns || kerberos` to look for name service traffic from the victim's IP to find their **Hostname**.
- **What you see:** You will see the victim IP (`10.4.19.136`) requesting the malicious ZIP file, and subsequent traffic revealing the computer name.
- **The "Why":** You cannot contain an incident until you know exactly which physical device is "patient zero" and what specific file started the infection.

### Step 5: Locate the Persistent C2 "BackConnect"
IcedID uses a specific "BackConnect" protocol for remote control, often over port 443 but without standard HTTPS web traffic.
- **Filter:** `tcp.flags.syn == 1 && tcp.port == 443`
- **Analysis:** Look for an IP address that the victim workstation connects to repeatedly *after* the infection time, where the traffic does not look like normal web browsing (no SNI or certificate info).
- **The "Why":** The BackConnect server is the attacker's "remote desktop" into your network. Finding this IP is the top priority for stopping the attacker's active control.

## Conclusion
By following these steps, you have successfully identified the delivery vector, the compromised workstation's identity, and the active C2 server.

## Cleanup & Reset
To ensure the environment is ready for the next candidate, please perform the following steps:
1. Close the web browser.
2. In the terminal window, run the following command to reset the scenario:
   ```bash
   ./scenario2.sh reset
   ```
