# Host Scenario 1: Reversing Obfuscated PowerShell

## Background
During a routine sweep of a workstation, a suspicious PowerShell script was found in the `C:\Users\Public\Documents\` directory. The script appears to contain an encoded blob that is decoded and executed at runtime. Your goal is to use **CyberChef** to reveal the hidden command and understand what changes it makes to the system.

## Objectives
1. Identify the encoding and encryption methods used in the script.
2. Use CyberChef to decode the `$EncodedBlob`.
3. Determine the final command being executed and the registry key it modifies.

## Walkthrough

### Step 1: Open CyberChef
1. Open a web browser and select the bookmark for CyberChef.  This will open a local copy of **CyberChef** that is located in the `host_dfir/host_scenario_1` directory.
2. Once CyberChef is open, select the rectangle with an arrow pointed towards the right to import a file from the system.  Import `host_dfir/host_scenario_1/encoded_malware.ps1`.

### Step 2: Decode the Payload
1. There is some encoded data contained within this PowerShell script.  Identify it, copy the encoded data, and pastse it into a new input tab by selecting the plus sign in the top right.
2. In CyberChef, drag the following "Operations" from the left pane into the "Recipe" pane in order (some of these options may be suggested to you from the CyberChef wizard):
  A. **From Base64**: This is identified by the `$Bytes = [System.Convert]::FromBase64String` line in the script.
  B. **Gunzip**: This matches the `GzipStream` line in the script.
  C. **XOR Brute Force**: Without knowing the key used for the XOR operation, we can brute force the possible output to find the key.  *Note: The key length is only one byte.*

### Step 3: Examine the Output
1. Look at the **Output** pane in CyberChef. You should now see a cleartext PowerShell command!
2. Do some open source research on the output to learn what the malicious script is attempting to do.
- **The "Why":** Attackers use obfuscation (encoding, compression, and encryption) to hide their activities from antivirus software and security analysts. Learning to "peel back the layers" is a fundamental skill in **Malware Analysis**.

## Conclusion
You have successfully reversed the obfuscation to reveal that the script creates a persistence mechanism in the Windows Registry to run a file named `totes_legit_not_malware.exe` on startup.

## Cleanup & Reset
1. Close the web browser.
