$files=Get-ChildItem $PSScriptRoot/.. -Recurse -Filter "*.bash" | % { $_.FullName }
$data=@()

#get statistics for each file
foreach($file in $files){
    $data+=Get-Content $file | Measure-Object -Word -Line
}

#this has to be in this order or the averages don't print out
#min, max, average
$data | Measure-Object -Property Words -Minimum -Maximum -Average
$data | Measure-Object -Property Lines -Minimum -Maximum -Average

#print the data
$data | select Words, Lines