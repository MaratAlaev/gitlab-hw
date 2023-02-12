# Домашнее задание к занятию `12.3. «SQL. Часть 1»` - `Алаев Марат`


### Задание 1

```SQL
select district 
from address
where district like 'K%' and district like '%a' and district not like '% %'
```


[Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/12.3_SQL1/img/1-1.png)


### Задание 2

```SQL
select p.payment_date, c.first_name, c.email , c.address_id 
from payment p, customer c
where p.payment_date >= "2005-06-15" and p.payment_date <= "2005-06-18" and p.amount > 10.00
and p.customer_id = c.customer_id
```

[Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/12.3_SQL1/img/2-1.png)


### Задание 3

```SQL
 select r.rental_date, r.rental_id 
   FROM rental r 
   ORDER BY rental_id desc 
   limit 5
```


[Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/12.3_SQL1/img/3-1.png)


### Задание 4

```SQL
  select c.active, lower(replace(c.first_name, 'LL', 'pp'))
   from customer c 
   where c.active = 1 and c.first_name = "Kelly" or c.first_name = "Willie"
```



[Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/12.3_SQL1/img/4-1.png)


### Задание 5

```SQL
select c.active, substring_index(c.email, '@', 1) , substring_index(c.email, '@', -1) 
   from customer c 
```

[Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/12.3_SQL1/img/5-1.png)


### Задание 6

```SQL
   select c.active, CONCAT(UPPER(SUBSTRING(substring_index(c.email, '@', 1) ,1,1)),LOWER(SUBSTRING(substring_index(c.email, '@', 1),2))) , substring_index(c.email, '@', -1) 
   from customer c 
```

[Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/12.3_SQL1/img/6-1.png)
