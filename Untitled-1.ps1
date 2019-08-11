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

$temp = ""
$collection = "Add-VpnConnection", "-Name ""AdasPack_Test"" -ServerAddress 213.135.90.163"
foreach ($Param in $collection)
{
    $temp = $temp + $Param
}
& $temp

#Команда = Новый Команда;
#Команда.УстановитьКоманду("oscript");
#Команда.ДобавитьПараметр("-version");	
#// или сразу Команда.УстановитьСтрокуЗапуска("oscript -version");
#КодВозврата = Команда.Исполнить();

$prm = 'a', '-tzip', 'c:\temp\with space\test1.zip', 'C:\TEMP\with space\changelog'

& 7z.exe $prm