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
join staff s2 on s.store_id = s2.staff_id 
join city c2 on c2.city_id = a.city_id 
group by s.store_id, s2.staff_id
having count(c.customer_id) > 300
```

я попробовал поправить это задание 
но все еще не до конца понимаю в чем еще тут проблема


![image](https://user-images.githubusercontent.com/46092593/224724524-6a77cd45-2343-40f6-aec3-0e191041a3e9.png)


### Задание 2

Получите количество фильмов, продолжительность которых больше средней продолжительности всех фильмов.

```SQL
select count(f.film_id) 
from film f
where f.`length` > (select avg(f.`length`) from film f)
```

![image](https://user-images.githubusercontent.com/46092593/224725752-0a90a946-bec5-44e3-acab-5738b2b0257a.png)



### Задание 3

Получите информацию, за какой месяц была получена наибольшая сумма платежей, и добавьте информацию по количеству аренд за этот месяц.

```SQL
select sum(p.amount), count(r.rental_id) 
from rental r 
join payment p on p.rental_id = r.rental_id 
group by date_format(p.payment_date, "%m %Y")
having sum(p.amount) >= all(
select sum(p2.amount) from payment p2 group by date_format(p2.payment_date, "%m %Y"))
```

![image](https://user-images.githubusercontent.com/46092593/224730013-1b81ee15-6cb3-4bca-ada9-7d2c4f65efcc.png)



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
where i.film_id is null
```

![image](https://user-images.githubusercontent.com/46092593/224732245-a7b08b1c-23ef-4380-bb8f-8afa89b90f51.png)

