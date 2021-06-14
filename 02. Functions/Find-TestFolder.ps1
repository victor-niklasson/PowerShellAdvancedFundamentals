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
    }
}