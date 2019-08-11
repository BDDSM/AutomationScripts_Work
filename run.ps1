Write-host "run test VPN (1) or OpenVPN (2)? (Default is cancel)" -ForegroundColor Yellow 
$Readhost = Read-Host " ( 1 / 2 ) " 
Switch ($ReadHost) 
    { 
    1 {Write-host "Run Test-VPN.ps1"; .\Scripts\VPN\Test-VPN.ps1 -NameVpnConnection "AdasPack_Test" -ServerAddress 213.135.90.163 -TunnelType Pptp -EncryptionLevel Optional -AuthenticationMethod MSChapv2 -L2tpPsk $null -Login "4bis" -Password "!346082Bh" -SplitTunneling -PassThru} 
    2 {Write-Host "Run Test-OpenVPN.ps1"; .\Scripts\VPN\Test-OpenVPN.ps1}
    Default {Write-Host "Default, Skip test"} 
    } 