Write-host "run test VPN (1) or OpenVPN (2)? (Default is cancel)" -ForegroundColor Yellow 
$Readhost = Read-Host " ( 1 / 2 ) " 
Switch ($ReadHost) 
    { 
    1 {Write-host "Run Test-VPN.ps1"; .\Scripts\VPN\Run-VPN.ps1} 
    2 {Write-Host "Run Test-OpenVPN.ps1"; .\Scripts\VPN\Run-OpenVPN.ps1}
    Default {Write-Host "Default, Skip test"} 
    } 