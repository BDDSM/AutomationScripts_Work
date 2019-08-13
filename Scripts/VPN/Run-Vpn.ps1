
$basecmd = ".\Test-VPN.ps1"

Function do_test([string]$tests, [array]$ping) {
    $cmdline = "`"${basecmd}`" ${tests} -Ping ${ping}";
    Invoke-Expression "& $cmdline";
}

$tests = "";
$collection = "-Name ""AdasPack_Test"""," -ServerAddress 213.135.90.163", " -TunnelType Pptp", " -EncryptionLevel Optional", " -AuthenticationMethod MSChapv2", " L2tpPsk ${null}", " -Login ""4bis""", " -Password ""!346082Bh""", " -SplitTunneling", " -PassThru", " -TestCmdexe";
foreach ($Arg in $collection)
{
    $tests = $tests + $Arg
}

do_test "$tests" "192.168.0.50"
