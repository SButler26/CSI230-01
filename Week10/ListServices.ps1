$responses=@("all","stopped","running","quit")
$input=$False

while($input -eq $False){
    #get user input
    $response = Read-Host -Prompt "Do you want to see >all, >running, or >stopped services, or >quit the program?:"
    #check if the input is valid
    $input=$($responses -eq $response) -ne $NULL
}

#output all services if all, only running or stopped, or output nothing if quit is entered
if($response -ilike "all"){
    Get-Service
} elseif ($response -inotlike "quit"){
    Get-Service | where { $_.Status -ilike $response }
}