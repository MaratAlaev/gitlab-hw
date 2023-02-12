# Домашнее задание к занятию `12.1. «Базы данных»` - `Алаев Марат`


### Задание 1

[Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/12.1_DB/img/1-1.png)

```

create table Employees
(
	id_employees   int primary key,
	fullName 	   varchar(80) not null,
	dateHired      date not null,
	id_position    int unique foreign key references Position(id_position),
	id_project     int unique foreign key references Project(id_project),
	id_subdivision int unique foreign key references Subdivision(id_subdivision),
)

create table Position
(
	id_position int primary key,
	position 	varchar(40),
	salary		money(10),
)

create table Project
(
	id_project  int primary key,
	position 	varchar(40),
	salary		money(10),
)

create table EmployeesProject
(
	id_project   int unique foreign key references Project(id_project),
    id_employees int unique foreign key references Employees(id_employees),
)

create table Subdivision 
(
	id_subdivision	int primary key,
	typeSubdivision	varchar(15) not null,
	structural	    varchar(80) not null,
)

create table Affiliate
(
	id_affiliate int primary key,	 
	address		 varchar(200),
)

create table SubdivisionAffiliate
(
	id_subdivision	int unique foreign key references Subdivision(id_subdivision),
	id_affiliate	int unique foreign key references Affiliate(id_affiliate),
)
```


### Задание 2

Думаю тут функциональная зависимость в id 
думаю тут нужно использовать Рефлексивность

id одной таблицы  определяет id другой таблицы 



  
