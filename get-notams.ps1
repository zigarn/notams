#!/usr/bin/env pwsh

$config_path = $args[0]
if (! $config_path) {
    $config_path = "./config.json"
}

# Ensures that Invoke-WebRequest uses TLS 1.3
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls13

Set-Variable -Name locations_size -option Constant -value 10

# Load config
$config = Get-Content -Raw -Path $config_path | ConvertFrom-Json

Set-Variable -Name base_url -option Constant -value ("https://applications.icao.int/dataservices/api/notams-realtime-list?api_key=" + $config.icao_api_key + "&format=json")

$now = Get-Date -AsUTC -Format "yyyy-MM-ddTHH-mm-ssZ"
$out_file = "notams_" + $now + ".txt"
New-Item -Path $config.output_folder -Force -ItemType Directory | Out-Null
New-Item -Path $config.output_folder -Name $out_file -ItemType File | Out-Null
$out_path = $config.output_folder + "/" + $out_file

for ($i = 0; $i -lt $config.locations.Count / $locations_size; $i++) {
    $begin = $locations_size * $i
    $end = $locations_size * ($i + 1) - 1
    $locations = $config.locations[$begin..$end]
    $url = $base_url + "&locations=" + ($locations | Join-String -Separator ',')
    $notams = Invoke-WebRequest -Uri $url | ConvertFrom-Json
    foreach ($notam in $notams) {
        Add-Content -Path $out_path -Value $notam.all
        Add-Content -Path $out_path -Value '---'
    }
}
