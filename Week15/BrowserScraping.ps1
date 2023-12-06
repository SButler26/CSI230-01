$url = "https://classlist.champlain.edu/show/courses/semester/spring/type/dayevening"

#Start Internet Explorer
$ie = New-Object -ComObject internetexplorer.application
$ie.navigate($url)
while($ie.ReadyState -ne 4) {Start-Sleep 3}

$fullTable = @()
$trs = $ie.Document.getElementsByTagName("tr")

for($i=1; $i -lt $trs.Length; $i++){
    $tds = $trs[$i].getElementsByTagName("td")
    $fullTable += [pscustomobject]@{"Number" = $tds[0].innerText;`
                                     "Title" = $tds[1].innerText;`
                                      "Days" = $tds[4].innerText;`
                                     "Times" = $tds[5].innerText;`
                                "Instructor" = $tds[6].innerText}
}

#$fullTable | select Number, Instructor, Days, Times | where { $_.Number -ilike "CSI*" }
#$fullTable | select Number, Instructor, Days, Times | where { $_.Number -ilike "CSI 2*" }
#$fullTable | select Number, Instructor, Days, Times | where { ($_.Number -ilike "CSI 3*") -and ($_.Days -ilike "*W*") }
#$fullTable | select Number, Title, Instructor, Days | where { ($_.Number -ilike "CSI*") -and ($_.Instructor -ilike "*Staff") }
$fullTable | select Number, Title, Instructor, Days | where { $_.Title -ilike "*Programming*" }

$ie.Quit()