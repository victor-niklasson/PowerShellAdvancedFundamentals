function Add-FiveToNumber {
    [CmdletBinding()]
    param (
        [decimal]$Number
    )
    $Number = Read-Host -Prompt 'Please enter a number  '
    $Number
    $Awnser = $Number+[int]5
    Write-Host "With five added to your number it would be: $Awnser"
}