# Network DFIR Scenario 3: Answers & Key Findings

## 1. Network details
- **Compromised Client IP:** `192.168.1.100`
- **C2/Nameserver Domain:** `tunnel.c2server.org`
- **DNS Query Type:** `TXT` (type 16)

## 2. Exfiltration Payload Reconstruction
The exfiltrated hex chunks are:
- Chunk 0: `434f4e464944454e5449414c202d2049`
- Chunk 1: `4e5445524e414c204f4e4c590a50726f`
- Chunk 2: `6a6563743a204963617275730a546172`
- Chunk 3: `6765743a2052656c6561736520506c61`
- Chunk 4: `6e0a466c61673a20464c41477b644e73`
- Chunk 5: `5f74556e4e654c694e675f657846696c`
- Chunk 6: `5f735563536553735f38383932317d0a`
- Chunk 7: `5374617475733a20436f6d706c657465`
- Chunk 8: `640a`

Concatenated Hex:
`434f4e464944454e5449414c202d20494e5445524e414c204f4e4c590a50726f6a6563743a204963617275730a5461726765743a2052656c6561736520506c616e0a466c61673a20464c41477b644e735f74556e4e654c694e675f657846696c5f735563536553735f38383932317d0a5374617475733a20436f6d706c657465640a`

## 3. Decoded Document
Decoding the concatenated hex string in CyberChef (From Hex) yields:
```text
CONFIDENTIAL - INTERNAL ONLY
Project: Icarus
Target: Release Plan
Flag: FLAG{dNs_tUnNeLiNg_eXfIl_sUcCeSs_88921}
Status: Completed
```

- **Project Name:** `Icarus`
- **Secret Flag:** `FLAG{dNs_tUnNeLiNg_eXfIl_sUcCeSs_88921}`
