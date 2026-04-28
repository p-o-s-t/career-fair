# Host Scenario 1 Analysis - Answer Key

## Objective 1: Obfuscation Methods
- **Methods Identified:**
    - **Base64 Encoding:** Identified by `[System.Convert]::FromBase64String`.
    - **Gzip Compression:** Identified by `System.IO.Compression.GzipStream`.
    - **XOR Encryption:** Identified by the `-bxor` operator in the script logic.
- **Explanation:** Using multiple layers of obfuscation is a common technique to bypass simple string-based detection from antivirus engines.

## Objective 2: CyberChef Recipe
- **Correct Recipe:**
    1. **From Base64**
    2. **Gunzip**
    3. **XOR Brute Force** (or **XOR** with Key: `42`)
- **Findings:** The XOR Brute Force reveals the cleartext when the key is `0x42`.

## Objective 3: Final Malicious Command
- **Command Revealed:** `NeW-iTeMpRoPeRtY -pat "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name "WindowsUpdater" -val "totes_legit_not_malware.exe" -prop String`
- **Registry Key Modified:** `HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce`
- **Value Added:** `WindowsUpdater` with data `totes_legit_not_malware.exe`
- **Explanation:** This command establishes **Persistence**. The `RunOnce` registry key ensures that `totes_legit_not_malware.exe` will be automatically executed the next time the system starts up.

## Summary of Findings
| Artifact | Value |
|----------|-------|
| XOR Key  | `0x42` |
| Registry Path | `HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce` |
| Malicious Binary | `totes_legit_not_malware.exe` |
| Technique | Persistence via Registry Run Keys |
