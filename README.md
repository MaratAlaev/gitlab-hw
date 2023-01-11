# Домашнее задание к занятию `10.5 Балансировка нагрузки. HAProxy/Nginx` - `Алаев Марат`

### Задание 1

Это сервис который занимается распределением нагрузки 
на приложения, гарантирует, что приложения не будут перегружены 
бывают как хардвейр так и софт решения


### Задание 2

 Round Robin - последовательное распределение запросов на пул серверов 
подходит в том случае если все сервера имеют одинаковую мощность

 Weighted Round Robin - похож на Round Robin за исключением того 
что нагрузку можно распределить неравномерно 
то есть на более мощный сервер можно увеличить нагрузку на более слабый уменьшить
это должно хорошо подойти если пул серверов имеет разную мощность


### Задание 3

[Cкриншот к заданию 3](https://github.com/MaratAlaev/gitlab-hw/blob/10.5_HAProxy/Nginx/img/10-5-3-1.png)

### Задание 4

[Cкриншот к заданию 4](https://github.com/MaratAlaev/gitlab-hw/blob/10.5_HAProxy/Nginx/img/10-5-4-1.png)

### Задание 5 

```
user www-data;

worker_processes auto;

pid /run/nginx.pid;

include /etc/nginx/modules-enabled/*.conf;


events {}

http {
	sendfile on;

	tcp_nopush on;

	types_hash_max_size 2048;


	include /etc/nginx/mime.types;

	default_type application/octet-stream;

	add_header Content-Type text/plain;


	ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POODLE

	ssl_prefer_server_ciphers on;




	access_log /var/log/nginx/access.log;
error_log /var/log/nginx/error.log;
gzip on;

application/xml application/xml+rss text/javascript;



	include /etc/nginx/conf.d/*.conf;

	include /etc/nginx/sites-enabled/*;


	server {

		listen     8088;
	

	location /ping {

	 return 200	'nginx is configured correctly';

	}

     }

}
```

[Cкриншот к заданию 5](https://github.com/MaratAlaev/gitlab-hw/blob/10.5_HAProxy/Nginx/img/10-5-5-1.png)


### Задание 6

```
frontend http_front

   mode http

   bind *:8080

   default_backend node



backend node

   mode http

   balance roundrobin

   http-request set-path /ping

   server s1 192.168.123.4:8088
```

[Cкриншот к заданию 6](https://github.com/MaratAlaev/gitlab-hw/blob/10.5_HAProxy/Nginx/img/10-5-6-1.png)