# Automation scripts (Work)

`Корпоративный репозиторий, прошу всех при добавлении информации обновлять и описание содержимого`
> Хранилище наработок для автоматизации ServiceDesk компании 4bis.ru

## Содержимое

Скрипты PowerShell

* Win VPN.ps1 - Создание, подключение, разъединение и удаление Windows VPN соединения по данным клиента (Пример); 
  `.\Test-Vpn.ps1 -NameVpnConnection "Adas Pack" -ServerAddress 213.135.90.163 -TunnelType Pptp -EncryptionLevel Optional -AuthenticationMethod MSChapv2 -Login "4bis" -Password "!346082Bh" -SplitTunneling -PassThru`
* Win OpenVPN.ps1 Для OpenVPN (В разработке). Для проверки используйте команду 
  `.\Test-Openvpn.ps1 -Config "C:\Program Files\OpenVPN\config\private.ovpn" -Ping 10.10.10.0 -TestCmdexe -TestService -TestGui`
