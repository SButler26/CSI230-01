$time="10/25/2023 1:53 PM"

ps | where { $_.StartTime -gt $time } | select ProcessName, StartTime