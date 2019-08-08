<#  Скрипт предназначен для автоматизации проверки доступов из itilium3
    При проверке шаги требуется выполнять последовательно #>

<#  Шаг1: Проверка имени пользователя и 
    Создание VPN подключения #>
$WinUserName = "ikarlo";
if ($env:UserName -eq $WinUserName) {Add-VpnConnection -Name "Adas Pack Test PowerShell" -ServerAddress "213.135.90.163" -TunnelType Pptp -EncryptionLevel Optional -AuthenticationMethod MSChapv2 -SplitTunneling -PassThru}

<#  Шаг2: Проверка статуса VPN подключения 
    Соединение VPN подключения #>
$vpnName = "Adas Pack Test PowerShell";
$login   = "4bis";
$pwd     = "!346082Bh";
$vpn = Get-VpnConnection -Name $vpnName;
if($vpn.ConnectionStatus -eq "Disconnected"){rasdial $vpnName $login $pwd}

<#  Шаг3: Проверка статуса VPN подключения 
    Отключение VPN подключения #>
$vpnName = "Adas Pack Test PowerShell";
$vpn = Get-VpnConnection -Name $vpnName;
if($vpn.ConnectionStatus -eq "Connected"){rasdial $vpnName /DISCONNECT}

<#  Шаг4: Удаление VPN подключения #>
$vpnName = "Adas Pack Test PowerShell";
Remove-VpnConnection -Name $vpnName -Force -PassThru
