# ООО "Украшение"

Приложение для Microsoft Windows, разработанное на WPF по компетенции "Программные решения для бизнеса", предназначенное для выполнении функции заказа товаров и обслуживание этих заказов.

# Установка и запуск

Для того, чтобы запустить приложение, требуется наличие MS SQL SERVER не менее 18 версии, а также Microsoft Visual Studio с поддержкой WPF проектов.


1. Скачайте и отредактируйте скрипт ```zxc.sql``` в следующих строках:

```
( NAME = N'TradeAnisimov', FILENAME = N'D:\SQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\TradeAnisimov.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TradeAnisimov_log', FILENAME = N'D:\SQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\TradeAnisimov_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
```

  Сделайте это таким образом, чтобы в ```FILENAME``` указывался путь хранения вашей базы данных.

2. Установите архив с программой WPF на свой ПК, и запустите файл ```testWPF.sln```
   После открытия проекта отредактируйте ```Properties.Settings```, переменную ```ConnectionString``` так, чтобы в ```Data Source=DESKTOP-QAPGNM7``` было записано имя вашего компьютера.

3. После сохранения всех изменений можете запустить проект по данной кнопке ![image](https://github.com/feelingod/Decorations/assets/128130924/91482c1a-582a-4af0-9c30-e813f692b202),
   или же запустить ```testWPF.exe``` по адресу``` testWPF2\testWPF\bin\Debug\net6.0-windows```

