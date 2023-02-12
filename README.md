# Домашнее задание к занятию `12.3. «SQL. Часть 1»` - `Алаев Марат`


### Задание 1

Получите уникальные названия районов из таблицы с адресами, которые начинаются на “K” и заканчиваются на “a” и не содержат пробелов.


```SQL
select district 
from address
where district like 'K%' and district like '%a' and district not like '% %'
```


![Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/12.3_SQL1/img/1-1.png)


### Задание 2

Получите из таблицы платежей за прокат фильмов информацию по платежам, которые выполнялись в промежуток с 15 июня 2005 года по 18 июня 2005 года включительно и стоимость которых превышает 10.00.


```SQL
select p.payment_date, c.first_name, c.email , c.address_id 
from payment p, customer c
where p.payment_date >= "2005-06-15" and p.payment_date <= "2005-06-18 23:59:59" and p.amount > 10.00
and p.customer_id = c.customer_id
```

![Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/12.3_SQL1/img/2-1.png)


### Задание 3

Получите последние пять аренд фильмов.

```SQL
 select r.rental_date, r.rental_id 
   FROM rental r 
   ORDER BY rental_id desc 
   limit 5
```


![Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/12.3_SQL1/img/3-1.png)


### Задание 4

Одним запросом получите активных покупателей, имена которых Kelly или Willie.

- Сформируйте вывод в результат таким образом:

- все буквы в фамилии и имени из верхнего регистра переведите в нижний регистр,
замените буквы 'll' в именах на 'pp'.


```SQL
  select c.active, lower(replace(c.first_name, 'LL', 'pp'))
   from customer c 
   where c.active = 1 and c.first_name = "Kelly" or c.first_name = "Willie"
```



![Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/12.3_SQL1/img/4-1.png)


### Задание 5

Выведите Email каждого покупателя, разделив значение Email на две отдельных колонки: в первой колонке должно быть значение, указанное до @, во второй — значение, указанное после @.


```SQL
select c.active, substring_index(c.email, '@', 1) , substring_index(c.email, '@', -1) 
   from customer c 
```

![Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/12.3_SQL1/img/5-1.png)


### Задание 6

Доработайте запрос из предыдущего задания, скорректируйте значения в новых колонках: первая буква должна быть заглавной, остальные — строчными.


```SQL
   select c.active, CONCAT(UPPER(SUBSTRING(substring_index(c.email, '@', 1) ,1,1)),LOWER(SUBSTRING(substring_index(c.email, '@', 1),2))) , substring_index(c.email, '@', -1) 
   from customer c 
```

![Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/12.3_SQL1/img/6-1.png)
