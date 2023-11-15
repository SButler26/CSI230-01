cd C:\xampp\apache\logs

#list apache logs
#Get-Content -Path .\access.log

#list last 5 logs
#Get-Content -Path .\access.log -Tail 5

#list 400/404 errors
#Get-Content -Path .\access.log | Select-String -Pattern ' 400 ',' 404 '

#list logs that are not ok
$6 = Get-Content -Path .\access.log | Select-String -Pattern ' 200 ' -NotMatch
#$6

#list logs that contain "error"
#$L = Get-Content -Path .\*.log | Select-String -Pattern 'error' 
#$L[-5..-1]

#display ip addresses from #6 (not OK)
$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
$ips = $regex.Matches($6) | select @{Name="IP"; Expression={ $_.value }}
#$ips

#count number of times an IP accessed the page
$counts = $ips | group IP -NoElement
#$counts

#add column to say if access count is greater than 3
$detailedCounts = $counts | select Count, Name, @{Name="Decision"; Expression={ if( $_.Count -gt 3 ) {"Abnormal"} else {"Normal"} }}
#$detailedCounts

#block abnormal IPs
foreach($ip in $detailedCounts){
    if([string]$ip.Decision -eq "Abnormal"){
        Write-Host "Blocking $ip"
        New-NetFirewallRule -DisplayName "Bad IP $ip.Name" -Direction Inbound -Action Block -RemoteAddress $ip.Name
    }
}

#remove blocks
#Remove-NetFirewallRule -DisplayName "Bad IP*"