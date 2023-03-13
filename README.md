# Домашнее задание к занятию `12.4. «SQL. Часть 2»` - `Алаев Марат`


### Задание 1

Одним запросом получите информацию о магазине, в котором обслуживается более 300 покупателей, и выведите в результат следующую информацию:

+ фамилия и имя сотрудника из этого магазина;
+ город нахождения магазина;
+ количество пользователей, закреплённых в этом магазине.

```SQL
select count(c.customer_id), concat(c.first_name, ' ', c.last_name), c2.city
from customer c
join store s  on c.store_id = s.store_id
join address a on a.address_id = s.address_id
join city c2 on c2.city_id = a.city_id 
group by s.store_id
having count(s.store_id) > 300
```

![image](https://user-images.githubusercontent.com/46092593/224708252-d69d9912-471c-48a0-847b-c8b5237c28d5.png)


### Задание 2

Получите количество фильмов, продолжительность которых больше средней продолжительности всех фильмов.

```SQL
select count(f.film_id) 
from film f
where f.rental_duration > (select avg(f.rental_duration) from film f)
```

![image](https://user-images.githubusercontent.com/46092593/224708384-5405e3e9-2dfb-49c2-b541-f05b180cc1ae.png)



### Задание 3

Получите информацию, за какой месяц была получена наибольшая сумма платежей, и добавьте информацию по количеству аренд за этот месяц.

```SQL
select sum(p.amount), count(r.rental_id) 
from rental r 
join payment p on p.rental_id = r.rental_id 
group by month(p.payment_date)
having sum(p.amount) >= all(
select sum(p2.amount) from payment p2 group by month(p2.payment_date))
```

![image](https://user-images.githubusercontent.com/46092593/224708489-fcbb4e6e-36b6-47f3-966f-5fdacaf83114.png)



### Задание 4

Посчитайте количество продаж, выполненных каждым продавцом. Добавьте вычисляемую колонку «Премия». Если количество продаж превышает 8000, то значение в колонке будет «Да», иначе должно быть значение «Нет».

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


![image](https://user-images.githubusercontent.com/46092593/224708639-98249e9b-39ff-456e-a92e-b26f9a6a0c1f.png)



### Задание 5

Найдите фильмы, которые ни разу не брали в аренду.

```SQL
select f.title 
from film f 
left join inventory i on i.film_id = f.film_id
left join rental r on i.inventory_id = r.inventory_id 
where r.rental_id is null
```

![image](https://user-images.githubusercontent.com/46092593/224708725-b4020c1e-ee85-4a3d-9a70-178fc8f961a9.png)

