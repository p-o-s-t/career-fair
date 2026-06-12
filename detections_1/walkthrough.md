# Detections Scenario 1: Writing YARA Rules for Suspicious Binaries

## Background
In cybersecurity, writing detection signatures is a key duty of Security Analysts, Incident Responders, and Threat Hunters. One of the most popular tools for this is **YARA**, which allows analysts to create rules to identify files based on textual or binary patterns (known as rulesets).

In this scenario, a compiled binary `suspicious_binary` was flagged by an automated network filter. The file is actually benign (it performs a system integrity check and exits), but it contains plaintext indicators that make it look suspicious. Your goal is to inspect the binary, identify these indicators, and write a YARA rule that triggers a detection alert on the binary.

*Note: This scenario runs directly on your local workstation.*

## Objectives
1. Determine the file type of `suspicious_binary` using a system tool.
2. Determine the SHA256 hash of `suspicious_binary` without using a guided command.
3. Inspect the strings inside the binary to find indicators of compromise (IoCs) and identify any obfuscated strings.
4. Create a YARA rule file named `my_rule.yar` targeting these indicators.
5. Test your YARA rule against the binary.

---

## Walkthrough

### Step 1: File Analysis & Metadata Identification
Open your terminal and navigate to the `detections_1` scenario directory:
```bash
cd detections_1
```

1. **Identify the File Type**:
   Use the `file` utility to determine what kind of file `suspicious_binary` is.
   ```bash
   file suspicious_binary
   ```
   *Question: What is the file type and architecture of the binary?*

2. **Calculate the Checksum**:
   Calculate the **SHA256** checksum of the `suspicious_binary` file. 
   *(Think about what command-line tool you would use on a Linux system to calculate a SHA256 hash).*
   *Question: What is the SHA256 hash of the binary?*

### Step 2: Inspect Strings & Analyze Obfuscation
1. Run the binary directly to see its behavior:
   ```bash
   ./suspicious_binary
   ```
   Notice that it runs a benign system integrity check and does not output any other information.

2. Run `strings` on the binary to perform static analysis and search for any suspicious indicators (such as external domain URLs or custom User-Agents):
   ```bash
   strings suspicious_binary
   ```
   *Question: Can you find the C2 URL (http://malicious-c2-server.net...) and User-Agent (MaliciousAgent...) in the strings output?*
   
4. Try to search for the registry key `Software\Microsoft\Windows\CurrentVersion\Run\Backdoor` using `grep`:
   ```bash
   strings suspicious_binary | grep "Backdoor"
   ```
   Notice that it returns **no results**! To evade simple static string matches, the attacker has *reversed* the registry key string inside the binary, and reconstructs it dynamically in memory only when printing.
   
5. Search the `strings` output for the reversed registry key (or search for the string `roodkcaB`):
   ```bash
   strings suspicious_binary | grep "roodkcaB"
   ```
   *Question: What is the full reversed registry key string found in the binary?*

6. Try to search the binary strings for the word "FLAG":
   ```bash
   strings suspicious_binary | grep "FLAG"
   ```
   Notice that it returns **no results**! By default, the `strings` command only extracts 1-byte ASCII strings. The flag in this binary has been stored as a **UTF-16 wide string** (2-byte characters) to evade simple scanners.

7. Search the binary for 16-bit little-endian wide strings by passing the `-el` flag to `strings`:
   ```bash
   strings -el suspicious_binary | grep "FLAG"
   ```
   *Question: What is the hidden flag found inside the binary?*

### Step 3: Write the YARA Rule
1. In the `detections_1` directory, create a new file named `my_rule.yar` using your preferred text editor.
2. Write a YARA rule that matches the binary using the C2 URL, the custom User-Agent, or the reversed registry key.
   
   A basic YARA rule structure:
   ```yara
   rule Detect_Suspicious_IntegrityCheck
   {
       meta:
           description = "Detects a suspicious integrity check tool containing static C2 indicators"
           author = "Security Analyst"
           sha256 = "<FILL_IN_SHA256_HASH_HERE>"

        strings:
            $c2_domain = "<FILL_IN_C2_URL_OR_DOMAIN>" ascii
            $user_agent = "<FILL_IN_SUSPICIOUS_USER_AGENT>" ascii
            $reg_key_reversed = "<FILL_IN_REVERSED_REGISTRY_KEY>" ascii
            $flag = "<FILL_IN_EXFILTRATED_FLAG_HERE>" wide

        condition:
            $c2_domain and ($user_agent or $reg_key_reversed or $flag)
    }
   ```
   *(Note: The `wide` modifier tells YARA to search for the UTF-16 wide string encoding of the flag, while `ascii` tells it to search for standard 1-byte ASCII representations).*
3. Save the file.

### Step 4: Test the YARA Rule
1. Run YARA in your terminal, passing your rule file and the target binary:
   ```bash
   yara my_rule.yar suspicious_binary
   ```
2. If your rule matches, YARA will print the rule name followed by the file path:
   ```txt
   Detect_Suspicious_IntegrityCheck suspicious_binary
   ```
3. If it doesn't output anything, check your strings or condition in `my_rule.yar` to ensure they match exactly!
