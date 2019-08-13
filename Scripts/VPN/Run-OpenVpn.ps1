
$configdir = "C:\Program Files\OpenVPN\config\iCarlo"
$basecmd = ".\Test-OpenVPN.ps1"

Function do_test([string]$tests, [string]$configname, [array]$ping) {
    $cmdline = "`"${basecmd}`" ${tests} -Config `"${configdir}\${configname}`" -Ping ${ping}"
    Invoke-Expression "& $cmdline"
}

$tests = "-TestCmdexe -TestGui -TestService"
do_test "$tests" "private.ovpn" "10.10.112.100"