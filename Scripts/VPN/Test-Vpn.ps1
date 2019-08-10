
Param (
    [string]$NameVpnConnection,
    [string]$ServerAddress,
    [string]$TunnelType,
    [string]$EncryptionLevel,
    [string]$AuthenticationMethod,
    [string]$Login,
    [string]$Password,
    [switch]$SplitTunneling,
    [switch]$PassThru,
    [switch]$Help
)

Function Show-Usage {
    Write-Host "Usage: Test-Vpn.ps1 ... TODO: make a description"
    Write-Host
    Write-Host "Parameters:"
    Write-Host "   -NameVpnConnection       ... TODO: make a description"
    Write-Host "   -ServerAddress           ... "
    Write-Host "   -TunnelType              ... "
    Write-Host "   -EncryptionLevel         ... "
    Write-Host "   -AuthenticationMethod    ... "
    Write-Host "   -Login                   ... "
    Write-Host "   -Password                ... "
    Write-Host "   -SplitTunneling          ... "
    Write-Host "   -PassThru                ... "
    Write-Host "   -Help                    Display this help"
    Write-Host
    Write-Host "Example: .\Test-Vpn.ps1 -NameVpnConnection ""Adas Pack"" -ServerAddress 213.135.90.163 -TunnelType Pptp -EncryptionLevel Optional -AuthenticationMethod MSChapv2 -Login ""4bis"" -Password ""!346082Bh"" -SplitTunneling -PassThru"
}

Function Check-Availability ([string]$Name) {
    $FindVpnConnection = Get-VpnConnection | WHERE {$_.Name -eq $Name} | SELECT Name
    if ($FindVpnConnection) {
        return 1
    } else {
        return 2
    }
}

Function Remove-Connection ([string]$Name) {
    Remove-VpnConnection -Name $Name -Force -PassThru
}

$res = Check-Availability ($NameVpnConnection);
if($res -eq 1){Remove-Connection ($NameVpnConnection)}

Add-VpnConnection -Name $NameVpnConnection -ServerAddress $ServerAddress -TunnelType $TunnelType -EncryptionLevel $EncryptionLevel -AuthenticationMethod $AuthenticationMethod -SplitTunneling -PassThru

$vpn = Get-VpnConnection -Name $NameVpnConnection;
if($vpn.ConnectionStatus -eq "Disconnected"){rasdial $NameVpnConnection $Login $Password}

$vpn = Get-VpnConnection -Name $NameVpnConnection;
if($vpn.ConnectionStatus -eq "Connected"){rasdial $NameVpnConnection /DISCONNECT}

Remove-Connection ($NameVpnConnection)

