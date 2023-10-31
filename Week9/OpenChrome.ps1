$Chrome=Get-Process | where { $_.ProcessName -eq "chrome" }
if($Chrome -ne $null){
    Write-Host "Stopping Chrome"
    Stop-Process -Name "chrome"
} else {
    Write-Host "Starting Chrome"
    Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList "https://www.champlain.edu/"
}