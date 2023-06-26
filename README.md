# Домашнее задание к занятию «SQL» - `Алаев Марат`


### Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose-манифест.

___


```Docker
docker run -d --name some-postgres \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=12341234 \
    -v ./data:/var/lib/postgresql/data \
    -v ./backup:/backup \
    postgres:12
```



### Задача 2
В БД из задачи 1:

- создайте пользователя test-admin-user и БД test_db;
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже);
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db;
- создайте пользователя test-simple-user;
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE этих таблиц БД test_db.
Таблица orders:

- id (serial primary key);
- наименование (string);
- цена (integer).

  
Таблица clients:

- id (serial primary key);
- фамилия (string);
- страна проживания (string, index);
- заказ (foreign key orders).


Приведите:

- итоговый список БД после выполнения пунктов выше;
- описание таблиц (describe);
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db;
- список пользователей с правами над таблицами test_db.
  
___

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/9533873a-ab22-4d0f-9e9f-bcc44105fc97)

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/18f0b1f1-3e7f-46b6-a65b-89f72707c1f0)

```SQL
select distinct grantor 
FROM information_schema.table_privileges
where table_catalog = 'test_db'
```

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/8773c057-7cb0-4468-be54-297187ac7f13)




### Задача 3

Используя SQL-синтаксис, наполните таблицы следующими тестовыми данными:

Таблица orders:

|Наименование|цена|
|------------|----|
|Шоколад|	10|
|Принтер|	3000|
|Книга|	500|
|Монитор|	7000|
|Гитара|	4000|

Таблица clients:

|ФИО|Страна проживания|
|---|-----------------| 
|Иванов Иван Иванович|	USA|
|Петров Петр Петрович|	Canada|
|Иоганн Себастьян Бах|	Japan|
|Ронни Джеймс Дио|	Russia|
|Ritchie Blackmore|	Russia|
Используя SQL-синтаксис:

вычислите количество записей для каждой таблицы.
Приведите в ответе:
```
- запросы,
- результаты их выполнения.
```
___

```SQL
INSERT INTO clients (id ,lastname ,country, "order")
VALUES (5, 'Ritchie Blackmore', 'Russia', 6);
```
```SQL
INSERT INTO orders (id,name,price)
VALUES (1, 'Шоколад', 10);
```
```SQL
SELECT COUNT(*) FROM clients c;
```
![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/30022757-a38a-4945-82dc-68df7231b289)

```SQL
SELECT COUNT(*) FROM orders o;
```

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/60972272-5163-4a9a-8774-7473bdecec50)



### Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys, свяжите записи из таблиц, согласно таблице:

|ФИО|	Заказ|
|---|------|
|Иванов Иван Иванович|	Книга|
|Петров Петр Петрович|	Монитор|
|Иоганн Себастьян Бах|	Гитара|

Приведите SQL-запросы для выполнения этих операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод этого запроса.

Подсказка: используйте директиву UPDATE.

___

```SQL
ALTER TABLE public.clients ADD CONSTRAINT clients_fk FOREIGN KEY ("order") REFERENCES orders(id)
```

```SQL
select lastname, name  from clients c, orders o 
where  c."order" = o.id 
```

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/a995fbb2-c241-427b-9e29-3233bb07b0f6)


### Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN).

Приведите получившийся результат и объясните, что значат полученные значения.
___

Hash Join  (cost=37.00..57.24 rows=810 width=64) - соединение по хешу, сохраняет одну таблицу в кеш
  Hash Cond: (c."order" = o.id) - сравнение значений из таблицы и таблицы с хешом
  ->  Seq Scan on clients c  (cost=0.00..18.10 rows=810 width=36) - полное сканирование таблицы 
  ->  Hash  (cost=22.00..22.00 rows=1200 width=36) - запись в кеш 
        ->  Seq Scan on orders o  (cost=0.00..22.00 rows=1200 width=36) - полное последовательное сканирование таблицы

### Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. задачу 1).

Остановите контейнер с PostgreSQL, но не удаляйте volumes.

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления.

___

```bash
pg_dump -U postgres test_db  > /backup/test_db.dump 
```
```docker
sudo docker run -d --name some-postgres-restore \                                                                                  
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=12341234 \
    -v ./backup:/backup \
    postgres:12
```
```bash
psql -U postgres -f /backup/test_db.dump 
```

