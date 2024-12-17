# Pfad zur Datei
$path = ".\Dockerfile"

# Lese die ersten drei Bytes der Datei
$bytes = Get-Content -Path $path -Encoding Byte -TotalCount 3

# Prüfe auf BOM
if ($bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
    Write-Output "Die Datei enthält ein UTF-8 BOM."
} else {
    Write-Output "Die Datei enthält KEIN UTF-8 BOM."
}
