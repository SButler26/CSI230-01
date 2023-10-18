Get-EventLog -List
$readLog = Read-Host -Prompt "Please select a log to check"
Get-EventLog -LogName $readLog -Newest 3 | Export-Csv -NoTypeInformation -Path "C:\Users\champuser\Desktop\log.csv"