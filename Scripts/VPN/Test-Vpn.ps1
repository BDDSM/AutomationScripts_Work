
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
    [array]$Ping,
    [switch]$TestCmdexe,
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
    Write-Host "   -Ping                    Target host(s) inside VPN to ping (should succeed). Separate multiple entries with commas."
    Write-Host "   -TestCmdexe              Test connection from the command-line"
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
    Remove-VpnConnection -Name $Name -Force
}

Function Test-Cmdexe {
    Check-Connectivity "cmdexe" $ping
}

Function Check-Connectivity ([string]$test_type, [array]$ping) {

    Start-Sleep -Seconds 3

    foreach ($target in $ping) {
        $connected = (Test-Connection -Computername $target -Quiet)

        if ($connected) {
            $result = "SUCCESS"
        } else {
            $result = "FAILURE"
        }

        Write-Host "${test_type} connection to ${target}: ${result}"
    }
}

Function do_test([string]$tests) {
    $cmdline = "${tests}";
    Invoke-Expression "& $cmdline";
}

$res = Check-Availability ($NameVpnConnection);
if($res -eq 1){Remove-Connection ($NameVpnConnection)}

$AddVpnConnection = New-Object System.Collections.ArrayList
$AddVpnConnection.Add("Add-VpnConnection")
If ($PSBoundParameters.ContainsKey('NameVpnConnection')) {
    $AddVpnConnection.Add("-Name " +   $PSBoundParameters.NameVpnConnection)
}
If ($PSBoundParameters.ContainsKey('ServerAddress')) {
    $AddVpnConnection.Add("-ServerAddress " + $PSBoundParameters.ServerAddress)
}
If ($PSBoundParameters.ContainsKey('TunnelType')) {
    $AddVpnConnection.Add("-TunnelType " + $PSBoundParameters.TunnelType)
}
If ($PSBoundParameters.ContainsKey('EncryptionLevel')) {
    $AddVpnConnection.Add("-EncryptionLevel " + $PSBoundParameters.EncryptionLevel)
}
If ($PSBoundParameters.ContainsKey('AuthenticationMethod')) {
    $AddVpnConnection.Add("-AuthenticationMethod " + $PSBoundParameters.AuthenticationMethod)
}
If ($PSBoundParameters.ContainsKey('L2tpPsk')) {
    $AddVpnConnection.Add("-L2tpPsk " + $PSBoundParameters.L2tpPsk)
}
If ($PSBoundParameters.ContainsKey('SplitTunneling')) {
    $AddVpnConnection.Add("-SplitTunneling")
}
If ($PSBoundParameters.ContainsKey('PassThru')) {
    $AddVpnConnection.Add("-PassThru")
}

do_test "$AddVpnConnection"

$vpn = Get-VpnConnection -Name $NameVpnConnection;
if($vpn.ConnectionStatus -eq "Disconnected"){rasdial $NameVpnConnection $Login $Password}

if ($TestCmdExe) { Test-Cmdexe }

$vpn = Get-VpnConnection -Name $NameVpnConnection;
if($vpn.ConnectionStatus -eq "Connected"){rasdial $NameVpnConnection /DISCONNECT}

Remove-Connection ($NameVpnConnection)
