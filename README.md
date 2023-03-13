# Домашнее задание к занятию `12.6. «Репликация и масштабирование. Часть 1»` - `Алаев Марат`


### Задание 1

+ активный master-сервер и пассивный репликационный slave-сервер - удобна для распределения запросов на чтение 
+ master-сервер и несколько slave-серверов - поможет лучше распределить запросы по множеству серверов
+ активный сервер со специальным механизмом репликации — distributed replicated block device (DRBD) - DRBD поможет распределить данные по блочным  устройствам на подобии RAID 1, то есть файлы будут и на основном сервере и на вспомогательном, что обеспечит нам надежность
+ SAN-кластер - основное преимущество заключается в том что SAN позволяет существующим устройствам хранения данных автоматически выполнять репликацию данных



### Задание 2


![image](https://user-images.githubusercontent.com/46092593/224770435-9e7ee2c4-388b-4b70-87b9-7c133d66c0d4.png)


Db user и DB book будут выполнены через вертикальный шардинг 
а Db store и Db store_copy через горизонтальное


### Задание 3

``` yaml
version: "3"
services:
  db_user:
    image: mysql:8-debian
    container_name: db_user
    ports:
      - 3003:3306
    environment:
      - MYSQL_ROOT_PASSWORD=pass
    networks:
      db_networks:
        ipv4_address: 172.20.0.10
    restart: always

  db_book:
    image: mysql:8-debian
    container_name: db_book
    ports:
      - 3004:3306
    environment:
      - MYSQL_ROOT_PASSWORD=pass
    networks:
      db_networks:
        ipv4_address: 172.20.0.11

  db_store:
    image: mysql:8-debian
    container_name: db_store
    ports:
      - 3005:3306
    environment:
      - MYSQL_ROOT_PASSWORD=pass
    networks:
      db_networks:
        ipv4_address: 172.20.0.12

  db_store_copy:
    image: mysql:8-debian
    container_name: db_store_copy
    ports:
      - 3006:3306
    environment:
      - MYSQL_ROOT_PASSWORD=pass
    networks:
      db_networks:
        ipv4_address: 172.20.0.13

networks:
  db_networks:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/24
``` 

```SQL
create database db_user;
use db_user;
create table user 
(
    id_user         int,
    name_user       varchar(20),
    rules           varchar(20),
    password_user   varchar(20),
    id_book         int
);

create database db_book;
use db_book;
create table book 
(
    id_book         int,
    name_book       varchar(20),
    author          varchar(20),
    year_book       date
);

create database db_store;
use db_store;
create table store 
(
    id_store        int,
    address_store   varchar(20),
    id_book         varchar(20)
);

create database db_store_copy;
use db_store_copy;
create table store 
(
    id_store        int,
    menagerie       varchar(20),
    saller          varchar(20),
    id_book         varchar(20)
);
```



