cd C:\Users\champuser\CSI230-01\Week9 
ls -File -Recurse | where { $_.CreationTime -gt "10/26/2023" } | Select-Object Name,CreationTime  | Export-Csv -NoTypeInformation -Path .\outFolder\recent.csv