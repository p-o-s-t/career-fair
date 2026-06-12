# Network DFIR Scenario 3: DNS Tunneling Detection & Data Exfiltration

## Background
A security alert was triggered by an internal intrusion detection system (IDS) flagging anomalous DNS activity. A workstation on the corporate network appears to be communicating with an external nameserver via unusually high volume and large DNS TXT queries. As a Network Security Analyst, you must analyze the captured traffic to determine if DNS tunneling was used to exfiltrate sensitive data, identify what domain was involved, and reconstruct the stolen data.

## Objectives
1. Identify the internal client IP and the C2/nameserver domain name.
2. Filter for the anomalous DNS traffic in Wireshark.
3. Extract the encoded exfiltration chunks.
4. Use CyberChef to decode the exfiltrated payloads and recover the stolen file containing the secret flag.

## Walkthrough

### Step 1: Start the Scenario
1. Open a terminal and start the Wireshark container:
   ```bash
   ./net_dfir_3/scenario.sh start
   ```
2. Open a web browser and navigate to `http://localhost:3004`. This opens a web-based instance of Wireshark running inside a container.
3. In Wireshark, click on **File** -> **Open**, navigate to `/data/`, and open `scenario_3.pcap`.

### Step 2: Analyze DNS Traffic
1. Apply a filter to display only DNS query packets:
   ```txt
   dns
   ```
2. Look through the queries. You will see some background traffic (e.g., google.com, github.com).
3. Identify the unusual queries. Notice a large number of queries targeting subdomains of `tunnel.c2server.org` with long, hexadecimal strings (e.g., `0.434f4e46...`).
4. Answer the following questions:
   - What is the IP address of the compromised client?
   - What is the malicious parent domain name used for the exfiltration tunnel?
   - What DNS query type (e.g., A, AAAA, TXT, MX) was used to carry the payload?

### Step 3: Extract the Payload Chunks
1. The subdomains are prefixed with an index number (e.g., `0.`, `1.`, `2.`) followed by a hexadecimal string.
2. Document each hex string in order:
   - Chunk 0: `434f4e464944454e5449414c202d2049`
   - Chunk 1: `4e5445524e414c204f4e4c590a50726f`
   - ... and so on.
3. Concatenate all of the hexadecimal strings together into one continuous string.
   *Tip: You can extract these easily by looking at the packet list, or copy them directly.*

### Step 4: Reconstruct and Decode the File
1. Open a web browser and access your local CyberChef instance (under `http://localhost/` or the bookmark you used in Host Scenario 1). Alternatively, use a public instance or standard decoding tools.
2. Paste the full, concatenated hexadecimal string into the **Input** pane.
3. Drag the **From Hex** operation into the **Recipe** pane.
4. Examine the **Output** pane! You should see the cleartext contents of the exfiltrated document.
5. Answer the following questions:
   - What is the name of the project mentioned in the exfiltrated file?
   - What is the secret flag contained within the document?

## Cleanup
Once you have retrieved the flag, stop the environment:
```bash
./net_dfir_3/scenario.sh stop
```
