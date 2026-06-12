# Detections Scenario 1: Answers & Key Findings

## 1. File Metadata & Identification
- **File Type Command**: `file suspicious_binary`
- **File Type & Architecture**: `ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV)` (indicates a standard Linux compiled 64-bit ELF binary, not stripped).
- **SHA256 Checksum Command**: `sha256sum suspicious_binary`
- **SHA256 Hash**: `ca5330063266786530f7b1afd278d1d81bb96430ff7d518395f93d9d60f4c61d`

## 2. Suspicious Indicators & Obfuscation
- **C2 Server URL:** `http://malicious-c2-server.net/api/v1/beacon` (can be found statically via strings).
- **User-Agent:** `Mozilla/5.0 (Windows NT 10.0; Win64; x64) MaliciousAgent/2.0` (can be found statically via strings).
- **Reversed Registry Key Search Command**: `strings suspicious_binary | grep "roodkcaB"`
- **Reversed Registry Key String:** `roodkcaB\nuR\noisreVtnerruC\swodniW\tfosorciM\erawtfoS` (resolves to `Software\Microsoft\Windows\CurrentVersion\Run\Backdoor` when reversed).
- **Hidden Flag:** `FLAG{yArA_dEtEcTiOn_sUcCeSs_99182}`

## 3. Sample YARA Rule
Below is a valid YARA rule that successfully triggers a match against the suspicious binary (matching the reversed key, custom agent, or URL):
```yara
rule Detect_Suspicious_IntegrityCheck
{
    meta:
        description = "Detects static C2 indicators inside suspicious binary"
        author = "Security Analyst"
        sha256 = "1c07a74a31d27b88431b74f2efbe30288d336ddb142b381b370a2e39a525365b"

    strings:
        $c2 = "http://malicious-c2-server.net" ascii
        $ua = "MaliciousAgent" ascii
        $reg_reversed = "roodkcaB\\nuR\\noisreVtnerruC\\swodniW\\tfosorciM\\erawtfoS" ascii
        $flag = "FLAG{yArA_dEtEcTiOn_sUcCeSs_99182}" wide

    condition:
        $c2 and ($ua or $reg_reversed or $flag)
}
```
