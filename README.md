# Домашнее задание к занятию `12.4. «SQL. Часть 2»` - `Алаев Марат`


### Задание 1

```SQL
select count(c.customer_id), concat(c.first_name, ' ', c.last_name), c2.city
from customer c
join store s  on c.store_id = s.store_id
join address a on a.address_id = s.address_id
join city c2 on c2.city_id = a.city_id 
group by s.store_id
having count(s.store_id) > 300
```



### Задание 2

```SQL
select count(f.film_id) 
from film f
where f.rental_duration > (select avg(f.rental_duration) from film f)
```




### Задание 3

```SQL
select sum(p.amount), count(r.rental_id) 
from rental r 
join payment p on p.rental_id = r.rental_id 
group by month(p.payment_date)
having sum(p.amount) >= all(
select sum(p2.amount) from payment p2 group by month(p2.payment_date))
```






### Задание 4

```SQL
select count(p.payment_id),
case
	when count(p.payment_id) > 8000 then 'да'
	when count(p.payment_id) < 8000 then 'нет'
end as премия
from staff s
join payment p on p.staff_id = s.staff_id 
group by s.staff_id 
```





### Задание 5

```SQL
select f.title 
from film f 
left join inventory i on i.film_id = f.film_id
left join rental r on i.inventory_id = r.inventory_id 
where r.rental_id is null
```
