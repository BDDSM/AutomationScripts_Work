
# Работа с архивными копиями в Microsoft SQL Server Management Studio

## Открыть MS SQL Studio

Запустите ярлык **Microsoft SQL Server Management Studio** через пуск или рабочий стол
Если не можете найти тогда откройте **Выполнить**  
Наберите **Ssms**
Нажмите **ОК**
Авторизуйтесь на сервере SQL

## Создать новый скрипт

Найдите на панели инструментов команду **Создать запрос**
Скопируйте нужный скрипт из приведенных ниже
Нажмите **Выполнить**

## Сделать копию рабочей базы (Скрипт)

Замените:

- **BaseForArchiving** на имя рабочей базы, которую нужно заархивировать
- **20190831** на текущую дату в формате 'ГГГГММДД'
- **E:\Backup** на каталог куда будет сохранена копия рабочей базы

```sql
BACKUP DATABASE [BaseForArchiving] TO  DISK = N'E:\Backup\BaseForArchiving_20190831.bak' WITH  DESCRIPTION = N'Архивная копия рабочей базы сделанная в ручную на дату 20190831', NOFORMAT, INIT,  NAME = N'BaseForArchiving-Полная База данных Резервное копирование', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'BaseForArchiving' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'BaseForArchiving' )
if @backupSetId is null begin raiserror(N'Ошибка верификации. Сведения о резервном копировании для базы данных "BaseForArchiving" не найдены.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'E:\Backup\BaseForArchiving_20190831.bak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO
```

## Восстановить копию рабочей базы в тестовой базе (Скрипт)

Замените:

- **BaseForRecovery** на имя тестовой базы, в которую нужно восстановить архив
- **BaseForArchiving** на имя рабочей базы, которая была заархивирована
- **E:\Backup\BaseForArchiving_20190831.bak** на путь до архивной копии из которой нужно восстановить архив рабочей базы

```sql
USE [master]
RESTORE DATABASE [BaseForRecovery] FROM  DISK = N'E:\Backup\BaseForArchiving_20190831.bak' WITH  FILE = 1,  MOVE N'BaseForArchiving' TO N'E:\SQLDB\BaseForRecovery.mdf',  MOVE N'BaseForArchiving_log' TO N'D:\SQLLOGS\BaseForRecovery_log.ldf',  NOUNLOAD,  REPLACE,  STATS = 5

GO
```
