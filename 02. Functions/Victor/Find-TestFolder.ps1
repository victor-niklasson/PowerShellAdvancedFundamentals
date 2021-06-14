function Find-Testfolder {
    [CmdletBinding()]
    param (
        [parameter(Mandatory)]
        [string]$Drive
    )
    $TestFolder = "${Drive}:\Temp\TestFolder"
    if(Test-Path $TestFolder) {
        Write-Host "$Drive has a test folder"
    }
    else{
    Write-Host "Can't find a test folder on $Drive"
    
    $CreateFolder = Read-Host -Prompt "Do you want to create one? y/n"
    $CreateFolder
    
    if($CreateFolder -eq 'y'){
        New-Item -Path "${Drive}:\Temp" -ItemType Directory -Name 'TestFolder'
        Write-Host "Created a test folder on $Drive"
        }
    }
}