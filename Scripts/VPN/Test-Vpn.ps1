<#  Скрипт предназначен для автоматизации проверки доступов из itilium3
    При проверке шаги требуется выполнять последовательно #>

<#  Шаг1: Проверка имени пользователя и 
    Создание VPN подключения #>
#$WinUserName = "ikarlo";
#if ($env:UserName -eq $WinUserName) {Add-VpnConnection -Name "Adas Pack Test PowerShell" -ServerAddress "213.135.90.163" -TunnelType Pptp -EncryptionLevel Optional -AuthenticationMethod MSChapv2 -SplitTunneling -PassThru}

<#  Шаг2: Проверка статуса VPN подключения 
    Соединение VPN подключения #>
#$vpnName = "Adas Pack Test PowerShell";
#$login   = "4bis";
#$pwd     = "!346082Bh";
#$vpn = Get-VpnConnection -Name $vpnName;
#if($vpn.ConnectionStatus -eq "Disconnected"){rasdial $vpnName $login $pwd}

<#  Шаг3: Проверка статуса VPN подключения 
    Отключение VPN подключения #>
#$vpnName = "Adas Pack Test PowerShell";
#$vpn = Get-VpnConnection -Name $vpnName;
#if($vpn.ConnectionStatus -eq "Connected"){rasdial $vpnName /DISCONNECT}

<#  Шаг4: Удаление VPN подключения #>
#$vpnName = "Adas Pack Test PowerShell";
#Remove-VpnConnection -Name $vpnName -Force -PassThru

####### Новая итерация скрипта

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

Add-VpnConnection -Name $NameVpnConnection -ServerAddress $ServerAddress -TunnelType $TunnelType -EncryptionLevel $EncryptionLevel -AuthenticationMethod $AuthenticationMethod -SplitTunneling -PassThru

$vpn = Get-VpnConnection -Name $NameVpnConnection;
if($vpn.ConnectionStatus -eq "Disconnected"){rasdial $NameVpnConnection $Login $Password}

$vpn = Get-VpnConnection -Name $NameVpnConnection;
if($vpn.ConnectionStatus -eq "Connected"){rasdial $NameVpnConnection /DISCONNECT}

Remove-VpnConnection -Name $NameVpnConnection -Force -PassThru

