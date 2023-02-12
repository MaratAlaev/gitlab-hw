# Домашнее задание к занятию `11.3. ELK` - `Алаев Марат`


### Задание 1

Установите и запустите Elasticsearch, после чего поменяйте параметр cluster_name на случайный.

Приведите скриншот команды 'curl -X GET 'localhost:9200/_cluster/health?pretty', сделанной на сервере с установленным Elasticsearch. Где будет виден нестандартный cluster_name.

![Cкриншот](https://github.com/MaratAlaev/gitlab-hw/blob/11.3_ELK/img/1-1.png)


### Задание 2

Установите и запустите Kibana.

Приведите скриншот интерфейса Kibana на странице http://<ip вашего сервера>:5601/app/dev_tools#/console, где будет выполнен запрос GET /_cluster/health?pretty.
  
![Cкриншот](https://github.com/MaratAlaev/gitlab-hw/blob/11.3_ELK/img/2-1.png)



### Задание 3

Установите и запустите Logstash и Nginx. С помощью Logstash отправьте access-лог Nginx в Elasticsearch.

Приведите скриншот интерфейса Kibana, на котором видны логи Nginx.

![Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/11.3_ELK/img/3-1.png)


### Задание 4

Установите и запустите Filebeat. Переключите поставку логов Nginx с Logstash на Filebeat.

Приведите скриншот интерфейса Kibana, на котором видны логи Nginx, которые были отправлены через Filebeat.

![Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/11.3_ELK/img/4-1.png)


### Задание 5

Настройте поставку лога в Elasticsearch через Logstash и Filebeat любого другого сервиса , но не Nginx. Для этого лог должен писаться на файловую систему, Logstash должен корректно его распарсить и разложить на поля.

Приведите скриншот интерфейса Kibana, на котором будет виден этот лог и напишите лог какого приложения отправляется.

![Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/11.3_ELK/img/5-1.png)


лог приложения PostgreSQL


  
