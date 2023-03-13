# Домашнее задание к занятию `12.5. «Индексы»` - `Алаев Марат`


### Задание 1

Напишите запрос к учебной базе данных, который вернёт процентное отношение общего размера всех индексов к общему размеру всех таблиц.

```SQL
select (sum(INDEX_LENGTH) / sum(DATA_LENGTH)) * 100
from information_schema.tables
where TABLE_SCHEMA = 'sakila'
```
![image](https://user-images.githubusercontent.com/46092593/224712473-9d12aa60-50c5-4bba-8ece-d82ba6c17a8e.png)


### Задание 2

Выполните explain analyze следующего запроса:

```SQL
select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)
from payment p, rental r, customer c, inventory i, film f
where date(p.payment_date) = '2005-07-30' and p.payment_date = r.rental_date and r.customer_id = c.customer_id and i.inventory_id = r.inventory_id
```
+ перечислите узкие места;
+ оптимизируйте запрос: внесите корректировки по использованию операторов, при необходимости добавьте индексы.

Больше всего потребляют оконные функции 
если их изменить , то запрос будет выполняться быстрее

так же я убрал лишний join 
и убрал функцию DATE так как она мешает использовать index

```SQL
SELECT CONCAT(c.last_name, ' ', c.first_name) AS customer_name,
  SUM(p.amount) AS total_amount
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN customer c ON r.customer_id = c.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE r.rental_date >= '2005-07-30' AND r.rental_date < '2005-07-31'
GROUP BY c.customer_id;
```

![image](https://user-images.githubusercontent.com/46092593/224749164-51fd8c34-5d1d-4af7-b9f7-0db90d486904.png)




### Задание 3

Самостоятельно изучите, какие типы индексов используются в PostgreSQL. Перечислите те индексы, которые используются в PostgreSQL, а в MySQL — нет.

GiST - это бинарное дерево в котором можно задать принцип распределения 
в обычном же бинарном дереве используется > < или = 
что не позволяет нормально работать с разными типами данных 
такие как геоданные, картинки и текст

SP-GiST - похож на своего собрата, в нем тоже можно задать принцип распределения 
но в нем можно разбить области значения на подобласти

GIN - состоит не из полных типов а из частей используется для поиска в тексте


BRIN - делит данные на определенные зоны 
и в случае того если запрос не обращается к какой-то зоне 
то ее сразу отметают

Bloom - подходит для усреднения большого количества данных 
чем меньше будет данных, тем с большим шансом bloom может ошибиться
