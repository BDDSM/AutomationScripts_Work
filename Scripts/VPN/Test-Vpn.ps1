
Param (
    [string]$NameVpnConnection,
    [string]$ServerAddress,
    [string]$TunnelType,
    [string]$EncryptionLevel,
    [string]$AuthenticationMethod,
    [string]$L2tpPsk,
    [string]$Login,
    [string]$Password,
    [switch]$SplitTunneling,
    [switch]$PassThru,
    [switch]$Help
)

Function Show-Usage {
    Write-Host "Usage: Test-Vpn.ps1 -NameVpnConnection <string> [-ServerAddress <string>] [-TunnelType <Pptp | L2tp | Sstp | Ikev2 | Automatic>] [-EncryptionLevel <NoEncryption | Optional | Required | Maximum | Custom>] [-AuthenticationMethod <Pap | Chap | MSChapv2 | Eap | MachineCertificate>] [-L2tpPsk <string>] [-Login <string>] [-Password <string>] [-SplitTunneling] [-PassThru] [-Help]"    
    Write-Host
    Write-Host "Parameters:"
    Write-Host "   -NameVpnConnection       Specifies the name of this VPN connection profile"
    Write-Host "   -ServerAddress           Specifies the address of the remote VPN server to which the client connects. You can specify the address as a URL, an IPv4 address, or an IPv6 address"
    Write-Host "   -TunnelType              Specifies the type of tunnel used for the VPN connection. The acceptable values for this parameter are: PPTP, L2TP, SSTP, IKEv2, Automatic"
    Write-Host "   -EncryptionLevel         Specifies the encryption level for the VPN connection. The acceptable values for this parameter are: NoEncryption, Optional, Required, Maximum,Custom"
    Write-Host "   -AuthenticationMethod    Specifies the authentication method to use for the VPN connection. The acceptable values for this parameter are: PAP, CHAP, MSCHAPv2, EAP, MachineCertificate"
    Write-Host "   -L2tpPsk                 Specifies the value of the PSK to be used for L2TP authentication. If this parameter is not specified, a certificate is used for L2TP"
    Write-Host "   -Login                   user account name (identifier)"
    Write-Host "   -Password                conditional word or set of signs designed to confirm identity or authority"
    Write-Host "   -SplitTunneling          Indicates that the cmdlet enables split tunneling for this VPN connection profile. When you enable split tunneling, traffic to destinations outside the intranet does not flow through the VPN tunnel. If you do not specify this parameter, split tunneling is disabled"
    Write-Host "   -PassThru                By specifying the PassThru parameter, you can see the configuration of the VPN connection object"
    Write-Host "   -Help                    Display this help"
    Write-Host
    Write-Host "Example: .\Test-Vpn.ps1 -NameVpnConnection ""Test"" -ServerAddress 10.10.10.10 -TunnelType Pptp -EncryptionLevel Optional -AuthenticationMethod MSChapv2 L2tpPsk ""qwerty123"" -Login ""TestLogin"" -Password ""TestPwd"" -SplitTunneling -PassThru"
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

#TODO сделать через Oscript, Пример:
#
#Команда = Новый Команда;
#Команда.УстановитьКоманду("oscript");
#Команда.ДобавитьПараметр("-version");	
#// или сразу Команда.УстановитьСтрокуЗапуска("oscript -version");
#КодВозврата = Команда.Исполнить();
#или
#$temp = ""
#$collection = "Add-VpnConnection", "-Name ""AdasPack_Test"" -ServerAddress 213.135.90.163"
#foreach ($Param in $collection)
#{
#    $temp = $temp + $Param
#}
#& $temp !!! Как выполнить пока не знаю...
#

Add-VpnConnection -Name $NameVpnConnection -ServerAddress $ServerAddress -TunnelType $TunnelType -EncryptionLevel $EncryptionLevel -AuthenticationMethod $AuthenticationMethod -L2tpPsk $L2tpPsk -SplitTunneling -PassThru

$vpn = Get-VpnConnection -Name $NameVpnConnection;
if($vpn.ConnectionStatus -eq "Disconnected"){rasdial $NameVpnConnection $Login $Password}

$vpn = Get-VpnConnection -Name $NameVpnConnection;
if($vpn.ConnectionStatus -eq "Connected"){rasdial $NameVpnConnection /DISCONNECT}

Remove-Connection ($NameVpnConnection)

#$exe = ′Add-VpnConnection ′
#$allargs = @(′ -?′)
#& $exe $allargs
#
#$exe = ′Add-VpnConnection -NameVpnConnection "AdasPack_Test" -ServerAddress 213.135.90.163 -TunnelType Pptp -EncryptionLevel Optional -AuthenticationMethod MSChapv2 -L2tpPsk "" -Login "4bis" -Password "!346082Bh" -SplitTunneling -PassThru′
#& $exe
#
#
#Invoke-Expression -Command ′Add-VpnConnection -Name "AdasPack_Test" -ServerAddress 213.135.90.163 -TunnelType Pptp -EncryptionLevel Optional -AuthenticationMethod MSChapv2 -L2tpPsk "" -Login "4bis" -Password "!346082Bh" -SplitTunneling -PassThru′
#
#$temp = ""
#$collection = "Add-VpnConnection", "-Name ""AdasPack_Test"" -ServerAddress 213.135.90.163"
#foreach ($Param in $collection)
#{
#    $temp = $temp + $Param
#}
#Command $temp


