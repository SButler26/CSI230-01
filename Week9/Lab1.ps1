$computer=(Get-NetIPAddress -AddressFamily IPv4 | where InterfaceAlias -ilike "Ethernet*")
$computer.IPAddress; $computer.PrefixLength

Get-WmiObject -list | where { $_.Name -ilike "Win32_Net*" } | Sort-Object

Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | select DHCPServer | Format-Table -HideTableHeaders

(Get-DnsClientServerAddress -AddressFamily IPv4 | where InterfaceAlias -ilike "Ethernet*").ServerAddresses[0]

cd C:\Users\champuser\CSI230-01\Week9

$files=(ls -Name)
for($i=0; $i -lt $files.Length; $i++){
    if($files[$i] -ilike "*.ps1"){
        $files[$i]
    }
}

$folderPath=".\outFolder"
if(Test-Path $folderPath){
    Write-Host "Folder Already Exists"
} else {
    New-Item -ItemType Directory -Path $folderPath
}

$filePath=-join($folderPath , "\out.csv")
$files | where { $_ -like "*.ps1" } | Export-Csv -Path $filePath

$files=ls -Recurse -File
$files | Rename-Item -NewName { $_.Name -replace '.csv' , '.log' }
ls -Recurse -File