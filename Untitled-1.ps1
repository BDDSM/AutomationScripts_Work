#$count = "" 
#$birds = "owl", "crow", "robin", ` 
#   "wren", "jay" 
#foreach ($bird in $birds) 
#{ 
#   $count = $count + $bird 
#   "$bird = " + $bird.length 
#   Write-Host 
#} 
#"Total number of birds is $count."

#$temp = ""
#$collection = "Add-VpnConnection", "-Name ""AdasPack_Test"" -ServerAddress 213.135.90.163"
#foreach ($Param in $collection)
#{
#    $temp = $temp + $Param
#}
#& $temp

#Команда = Новый Команда;
#Команда.УстановитьКоманду("oscript");
#Команда.ДобавитьПараметр("-version");	
#// или сразу Команда.УстановитьСтрокуЗапуска("oscript -version");
#КодВозврата = Команда.Исполнить();


$command = {Add-VpnConnection -Name "AdasPack_Test" -ServerAddress 213.135.90.163 -TunnelType Pptp -EncryptionLevel Optional -AuthenticationMethod MSChapv2 -SplitTunneling -PassThru}
invoke-command -scriptblock $command

#$command = { get-eventlog -log "windows powershell" | where {$_.message -like "*certificate*"} }
#invoke-command -scriptblock $command

#param($p1, $p2, $p3, $p4)
#$Script:args=""
#write-host "Num Args: " $PSBoundParameters.Keys.Count
#foreach ($key in $PSBoundParameters.keys) {
#    $Script:args+= "`$$key=" + $PSBoundParameters["$key"] + "  "
#}
#write-host $Script:args


