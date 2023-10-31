cd C:\Users\champuser\CSI230-01\Week9
ls -File -Recurse | where { $_.Name -ilike "*.ps1" } | Sort-Object { $_.CreationTime }