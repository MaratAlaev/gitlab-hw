# Домашнее задание к занятию `12.09. «Базы данных в облаке»` - `Алаев Марат`


### Задание 1

1.1. Необходимо восстанавливать данные в полном объеме за предыдущий день.

Тут бы я предложил делать полный бэкап, по окончанию рабочего времени 
так как в эти моменты нагрузка на сеть  не так страшна и времени хватит до начала следующего рабочего дня


1.2. Необходимо восстанавливать данные за час до предполагаемой поломки.

Здесь думаю стоит воспользоваться дифференциальным бэкапом 
так как это позволит быстро создавать резервные копии

1.3.* Возможен ли кейс, когда при поломке базы происходило моментальное переключение на работающую или подчиненную базу данных.


да, это возможно, если использовать репликацию
это позволи в случае поломки любой из бд, переключиться на рабочую



### Задание 2

2.1. С помощью официальной документации приведите пример команды резервирования данных и восстановления БД (pgdump/pgrestore).

$ pg_dump mydb > db.sql - передаем утилите название бд + путь файла дампа 

``` $ pg_restore -C -d mydb db.sql``` - 
“-C” создает базу данных с нужным именем + ее настойки 
“-d” имя базы данных 
в конце передаем сам дамп для восстановления



### Задание 3

mysqlbackup --defaults-file=/home/dbadmin/my.cnf --incremental \
backup

тут мы указываем файл бэкапа и тип бэкапа 

3.1.* В каких случаях использование реплики будет давать преимущество по сравнению с обычным резервным копированием?

в том случае если нам нужно максимально быстрое восстановление базы 
без потери времени 
но даже в таком случае стоит делать бэкап, так как в один момент все может пойти не так
