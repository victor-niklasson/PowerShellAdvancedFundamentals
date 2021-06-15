function New-majoFileInDirectory {
    [CmdletBinding(
        SupportsShouldProcess = $True
    )]
    param (
        [Parameter(
            Mandatory,
            Position = 0
        )]
        [ValidateScript(
            {
                if (Test-Path -Path $_) { throw "The file $_ already exists." }
            }
        )]
        [String]$Name
    )

    begin {

    }
    process {
        If ($PSCmdlet.ShouldProcess("Will create file $Name")) {
            New-Item -Name $Name -ItemType File
        }

    }
    end {

    }
}
function Get-majoService {
    [CmdletBinding()]

    class myService {
        [string]$DisplayName
        [System.ServiceProcess.ServiceControllerStatus]$Status
        [String]$BinaryPathName
        [void]GetFullname(){

            if ($this.BinaryPathName -like '*.exe"') {
                $ret = $this.BinaryPathName
            }else{
                $ret = ($this.BinaryPathName).split('.exe')[0]+".exe" # Complex split and
                #add to get fullpath of BinaryPathName (Which contains arguments)
            }
            $this.Fullname = $ret
        }
        [DateTime]$CreationTime
        [String]$Fullname
        [String]$Owner
    }
 

    $allservices = Get-Service # Get all services on this host

    $retarr = @()
    foreach ($s in $allservices) {
        $thisService = New-Object myService
        $thisService.DisplayName = $s.DisplayName
        $thisService.Status = $s.Status
        $thisService.BinaryPathName = $s.BinaryPathName -replace '"','' # Removing " " marks around string
        $thisService.GetFullname()
        if (Test-Path -Path $thisService.Fullname) {
            $thisService.CreationTime = (Get-item -path $thisService.Fullname).CreationTime 
            $thisService.Owner = (Get-Acl -Path $thisService.Fullname).Owner
        }
        $retarr += $thisService
    }
    $retarr
}