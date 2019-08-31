
# Рекомендованное ПО и расширения

`TODO: Планируется сделать batch-файлы для установки в пакетном режиме`
> В документе описаны инструменты которые упрощают работу с GIT, Docker и другими ПО используемые в автоматизации работы

## Chocolatey

Chocolatey - менеджер пакетов в среде Windows по аналогии с apt-get в Linux Мире. Помогает сократить поиск, установку и обновление софта до одной команды в консоли. Весь ниже перечисленный софт на Ваш выбор можно скачать и установить вручную или с помощью пакетного менеджера.

Установить можно скачав с официального сайта по [ссылке](https://chocolatey.org/) или с помощью консольных команд ниже.

### Установка через CMD

Запустить следующую команду: (Скопируйте текст команды)
`@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"`

### Установка через PowerShell

PowerShell должен быть запущен с правами администратора, если Вы не знаете как это сделать или проверить, то воспользуйтесь в открытом окне консоли скриптом:

```powershell
$IsAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")
if (-not $IsAdmin)
{
  Write-Output "The script is NOT running as Administrator, restarting PowerShell as Administrator..."
  Start-Process powershell -Verb runAs
  Stop-Process -Id $PID
}
```

Для PowerShell есть дополнительный шаг. Вы должны убедиться, что `Get-ExecutionPolicy` не ограничен. Мы предлагаем использовать `Bypass` для обхода политики, чтобы установить вещи, или `AllSigned` для большей безопасности.

Запустите `Get-ExecutionPolicy`. Если он возвращает `Restricted`, запустите `Set-ExecutionPolicy AllSigned` или `Set-ExecutionPolicy Bypass -Scope Process`.

Запустить следующую команду: (Скопируйте текст команды)
`Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`
или
`iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`

### Команды для установки программ через choco

`choco install chocolateygui`   - установка графического интерфейса chocolateygui, доступен из пуск.
`choco install 7zip.install`    - полный установочный файл 7zip или `choco install 7zip` содержащий только скрипт начала загрузки.
`choco install vscode`          - полный дистрибутив VSCode.
`choco install sourcetree`      - Git клиент от компании Atlassian с графическим интерфейсом.

`choco upgrade chocolatey`      - обновление пакет chocolatey.
`cup all`                       - обновление всех установленных пакетов приложений.

`choco uninstall chocolateygui` - удаление пакета chocolateygui.

`choco install git.install`     - полный установочный файл git или `choco install git` содержащий только скрипт начала загрузки. Для некоторых пакетов доступен список параметров установки. Разберем их на примере git:

* `/GitOnlyOnPath`            - Помещает `gitinstall\cmd` по указанному пути. Это также делается по умолчанию, если параметры пакета не установлены.
* `/GitAndUnixToolsOnPath`    - Помещает `gitinstall\bin` по указанному пути. Этот параметр переопределит `/GitOnlyOnPath`.
* `/NoAutoCrlf`               - Проверьте `Checkout as is, commit as is` . Эта настройка применяется, только при первоначальной установке, и не меняет `.gitconfig`.
* `/WindowsTerminal`          - Назначает обычный терминал Windows вместо терминала MinTTY.
* `/NoShellIntegration`       - Отключает установку стандартного Git GUI и интеграцию с оболочкой (записи "Git GUI Here" и "Git Bash Here" в контекстных меню).
* `/NoGuiHereIntegration`     - Отключает установку стандартного Git GUI и интеграцию с оболочкой (запись "Git GUI Here" в контекстных меню).
* `/NoShellHereIntegration`   - Отключает интеграцию с оболочкой (запись "Git GUI Here" в контекстных меню).
* `/NoCredentialManager`      - Отключает Git Credential Manager, добавив `$Env:GCM_VALIDATE='false'` в переменных средах пользователя.
* `/NoGitLfs`                 - Отключает установку Git LFS.
* `/SChannel`                 - Конфигурация Git для использования собственной реализации SSL/TLS (SChannel) вместо OpenSSL.

Пример: `choco install git.install --params "/GitAndUnixToolsOnPath /NoGitLfs /SChannel /NoAutoCrlf"`

`Создание собственного пакета, TODO изучить. https://chocolatey.org/docs https://chocolatey.org/docs/create-packages`

## Visual Studio Code

VSCode - Редактор исходного кода, разработанный Microsoft для Windows, Linux и macOS. Позиционируется как «лёгкий» редактор кода для кроссплатформенной разработки веб- и облачных приложений.

Скачать можно с официального сайта по [ссылке](https://code.visualstudio.com/)

### Extensions

Для расширения встроенных возможностей VSCode предназначена возможность устанавливать расширения.

Установка:

Откройте `Visual Studio Code`
Нажмите `Ctrl + P`, чтобы открыть диалоговое окно `Quick Open / Быстрое открытие`
Введите `ext install vscode-icons`, чтобы найти расширение
Нажмите кнопку `Установить`
ИЛИ

Нажмите `Ctrl + Shift + X`, чтобы открыть вкладку `Расширения`
Введите `vscode-icons`, чтобы найти расширение
Нажмите кнопку `Установить`
ИЛИ

Откройте командную строку (`command-line prompt / CMD`)
Выполнить `code --install-extension vscode-icons-team.vscode-icons`

Список имен рекомендуемых расширений:

* AutoFileName
* Bookmarks
* Bracket Pair Colorizer
* Chocolatey
* Docker
* docs-markdown
* Excel Viewer
* Gherkin step autocomplete
* Git Graph
* Git History
* GitLens — Git supercharged
* indent-rainbow
* hightlight-selections-vscode
* Language 1C (BSL)
* Markdown All in One
* Markdown Converter
* Markdown Navigation
* Markdown PDF
* Markdown Preview Enhanced
* Markdown Preview GitHub Styling
* Markdown Shortcuts
* markdownlint
* Markdown Extension Pack
* OneScript Debug
* Partial Diff
* REST Client
* Russian Language Pack for Visual Studio Code
* Spell Right
* Settings Sync
* Tester 1C
* Txt Syntax
* vscode-icons
* Zip File Explorer

## Git For Windows

Git - одна из самых популярных систем контроля версий, используется разработчиками, для контроля изменений в своих разработках и проектах. Изначально создан для использования на Linux-подобных операционных системах, но позднее, из-за удобства и популярности для Windows был написан специальный эмулятор, поддерживающий функционал Git’a.

Скачать можно с официального сайта по [ссылке](https://git-scm.com/downloads)

## Sourcetree

Бесплатный клиент Git для Windows и Mac. Sourcetree упрощает взаимодействие с репозиториями Git, поэтому вы можете сосредоточиться на кодировании. Визуализируйте и управляйте своими репозиториями с помощью простого графического интерфейса Git Sourcetree.

Скачать можно с официального сайта по [ссылке](https://www.sourcetreeapp.com/)
