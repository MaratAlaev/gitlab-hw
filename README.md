# Домашнее задание к занятию `MySQL` - `Алаев Марат`


### Задача 1

Используя Docker, поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

Изучите бэкап БД и восстановитесь из него.

Перейдите в управляющую консоль mysql внутри контейнера.

Используя команду \h, получите список управляющих команд.

Найдите команду для выдачи статуса БД и приведите в ответе из её вывода версию сервера БД.

Подключитесь к восстановленной БД и получите список таблиц из этой БД.

Приведите в ответе количество записей с price > 300.

В следующих заданиях мы будем продолжать работу с этим контейнером.

___

количество записей равно одному



### Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:

плагин авторизации mysql_native_password
срок истечения пароля — 180 дней
количество попыток авторизации — 3
максимальное количество запросов в час — 100
аттрибуты пользователя:
Фамилия "Pretty"
Имя "James".
Предоставьте привелегии пользователю test на операции SELECT базы test_db.

Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES, получите данные по пользователю test и приведите в ответе к задаче.


___

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/92122304-4765-4f63-8684-fec4f26d79eb)






### Задача 3
Установите профилирование SET profiling = 1. Изучите вывод профилирования команд SHOW PROFILES;.

Исследуйте, какой engine используется в таблице БД test_db и приведите в ответе.

Измените engine и приведите время выполнения и запрос на изменения из профайлера в ответе:

на MyISAM,
на InnoDB.
___

```SQL
SELECT TABLE_SCHEMA , ENGINE FROM information_schema.TABLES where TABLE_SCHEMA = 'test_dump';
```
![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/4b6a6a9b-4537-478a-b874-f94fd61db050)

UPDATE test_dump.orders SET price=600 WHERE id=5

MyISAM: 

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/693b74d0-275e-4335-ad1b-a8a64fdec06b)



InnoDB:

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/b249b346-04b9-41af-87d9-e8b699c2a470)




### Задача 4
Изучите файл my.cnf в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):

скорость IO важнее сохранности данных;
нужна компрессия таблиц для экономии места на диске;
размер буффера с незакомиченными транзакциями 1 Мб;
буффер кеширования 30% от ОЗУ;
размер файла логов операций 100 Мб.
Приведите в ответе изменённый файл my.cnf.

___

[mysqld]

innodb_file_per_table=1

innodb_buffer_pool_size=3G

log_bin=/var/log/mysql/mysql-bin.log

max_binlog_size=100M

innodb_flush_log_at_trx_commit=2 


skip-host-cache

skip-name-resolve

datadir=/var/lib/mysql

socket=/var/run/mysqld/mysqld.sock

secure-file-priv=/var/lib/mysql-files

user=mysql


pid-file=/var/run/mysqld/mysqld.pid

[client]

socket=/var/run/mysqld/mysqld.sock


!includedir /etc/mysql/conf.d/
