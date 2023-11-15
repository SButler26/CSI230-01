$input = Read-Host "1: Logons
2: Logoffs
3: Failed Logons
Input"

Switch ($input){
    1 {Get-EventLog system -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14) -InstanceId 7001}
    2 {Get-EventLog system -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14) -InstanceId 7002}
    3 {Get-EventLog security -After (Get-Date).AddDays(-14) -InstanceId 4625}
}