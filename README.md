# Automation scripts (Work)

`Корпоративный репозиторий, прошу всех при добавлении информации обновлять и описание содержимого`
> Хранилище наработок для автоматизации ServiceDesk

## Содержимое

Скрипты PowerShell

* Test-VPN.ps1 - Создание, подключение, разъединение и удаление Windows VPN соединения по данным клиента;
  `.\Test-Vpn.ps1 -NameVpnConnection ""Test"" -ServerAddress 10.10.10.10 -TunnelType Pptp -EncryptionLevel Optional -AuthenticationMethod MSChapv2 L2tpPsk ""qwerty123"" -Login ""TestLogin"" -Password ""TestPwd"" -SplitTunneling -PassThru`
* Test-OpenVPN.ps1 - Для OpenVPN. Для проверки используйте команду;
  `.\Test-Openvpn.ps1 -Config "C:\Program Files\OpenVPN\config\private.ovpn" -Ping 10.10.10.0 -TestCmdexe -TestService -TestGui`

Перед использованием скриптов проверьте текущие параметры политики, введя команду `Get-ExecutionPolicy`. Результатом будет одно из следующих значений:

* Restricted — выполнение скриптов запрещено. Стандартная конфигурация;
* AllSigned — можно запускать скрипты, подписанные доверенным разработчиком; перед запуском скрипта PowerShell запросит у вас подтверждение;
* RemoteSigned — можно запускать собственные скрипты или те, что подписаны доверенным разработчиком;
* Unrestricted — можно запускать любые скрипты.

Для начала работы необходимо изменить настройку политики запуска на RemoteSigned, используя команду `Set-ExecutionPolicy`.
