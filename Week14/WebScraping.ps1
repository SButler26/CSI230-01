$scrapedPage=Invoke-WebRequest -TimeoutSec 5 http://192.168.3.28/ToBeScraped.html

#2-4
$scrapedPage.Links.Count
$scrapedPage.Links
$scrapedPage.Links | select outerText,href

#5
$h2=$scrapedPage.ParsedHtml.body.getElementsByTagName("h2")
$h2 | select outerText

#6
for($i=0; $i -lt $h2.length; $i++){
    $h2[$i].getElementsByTagName("a") | select @{Name="h2 element"; Expression={$i}}, outerText, href
}

#7
$scrapedPage.ParsedHtml.body.getElementsByTagName("div") | where { $_.getAttributeNode("class").Value -ilike "div-1" } | select innerText

#9
$rows=$scrapedPage.ParsedHtml.body.getElementsByTagName("tr")
$table=@()
for($i=1; $i -lt $rows.length; $i++){
    $elements=$rows[$i].getElementsByTagName("td")
    $table += @(@{Row=$i; Employee=$elements[0].outerText; Department=$elements[1].outerText; Salary=$elements[2].outerText})
}
$table.Values

#10
Write-Host
$sum=0
$i=0
for($i; $i -lt $table.Length; $i++){
    $sum+=$table[$i]["Salary"]
}
$sum/($i)

#11
Write-Host
$scrapedPage.ParsedHtml.body.getElementsByTagName("div") | select id