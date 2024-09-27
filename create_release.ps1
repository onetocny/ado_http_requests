Param( 
[string]$organisation = "onetocny", 
[string]$project = "playground", 
[string]$keepForever = "true", 
[string]$user = "", 
[string]$token = "" ) 

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user,$token)))

$postresults = "https://vsrm.codedev.ms/$organisation/$project/_apis/release/definitions?api-version=5.0" 

$definition = Get-Content -Path .\definition.json | ConvertFrom-Json -Depth 10;

for ($i = 0; $i -lt 10000; $i++)
{
    $definition.name = "bbbbb{0:00000}D" –f $i;
    $definition.path = "\\gufug{0:00000}D" –f $i;
        

    $body = $definition | ConvertTo-Json -Depth 10


    Invoke-RestMethod -Uri $postresults -Method Post -Body $body -ContentType "application/json" -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}
    Write-Host $definition.name
}






