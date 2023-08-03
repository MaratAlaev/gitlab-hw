# Домашнее задание к занятию `Основы Terraform. Yandex Cloud` - `Алаев Марат`


### Задача 1

https://hub.docker.com/r/e2754/marat-netology



### Задача 2
Посмотрите на сценарий ниже и ответьте на вопрос: «Подходит ли в этом сценарии использование Docker-контейнеров или лучше подойдёт виртуальная машина, физическая машина? Может быть, возможны разные варианты?»
Детально опишите и обоснуйте свой выбор.
--
Сценарий:
высоконагруженное монолитное Java веб-приложение;
Nodejs веб-приложение;
мобильное приложение c версиями для Android и iOS;
шина данных на базе Apache Kafka;
Elasticsearch-кластер для реализации логирования продуктивного веб-приложения — три ноды elasticsearch, два logstash и две ноды kibana;
мониторинг-стек на базе Prometheus и Grafana;
MongoDB как основное хранилище данных для Java-приложения;
Gitlab-сервер для реализации CI/CD-процессов и приватный (закрытый) Docker Registry.


___

высоконагруженная база данных, чувствительная к отказу - думаю тут лучше будет использовать отдельную связку физических серверов с настроенной репликаций
так как тут нужна надежность 


различные web-приложения - лучше будет запускать на уровне виртуализации ОС
это позволит быстро разворачивать web приложения, а также уберет возможные проблемы связанные с зависимостями 



Windows-системы для использования бухгалтерским отделом - тут лучше использовать паравиртуализацию, на приватном офисном сервере, так как это даст надежность сохранности данных + у нас не будет зависимости от ядра ОС и не будет все забито на одной физической машине, это упростить администрирование этих серверов  



системы, выполняющие высокопроизводительные расчёты на GPU - думаю тут лучше всего использовать физические сервера, так как в других случаях будет потеря производительности 





Задача 3
Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.
Сценарии:
100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based-инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.
Требуется наиболее производительное бесплатное open source-решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.
Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows-инфраструктуры.
Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.

___

тут думаю лучшим решением будет Hyper-V или vmware workstation
так как функционал схожий и фичи тоже схожие, обе имеют хорошую производительность и гибкость, удобно настраивать и администрировать 
также можно делать целые снимки ОС 
тут лучше всего будет использовать Xen, так как имеет в себе высокую производительность и довольно надежный 

в этом случае думаю тоже хорошо подойдет Xen из-за все тех же причин, что и во втором варианте

тут думаю  подойдет  KVM как простой инструмент развертывания машин для тестов, также можно рассмотреть и Docker, но это зависит уже от тестов и самого типа программного обеспечения 

Задача 4
Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.

___

из собственного опыта рекомендую так не делать 
так как например часто встречался с конфликтами между Vmware и virtualbox
так как иногда, одно из-за друго ломается, что потом приходится чинить 
плюс еще WSL из-за этого то работает то нет 

вообщем не рекомендую, лучше разделить машины в таком случае 

ну если возможности нет, я бы включил поддержку виртуализации в самой VM 
и там бы запустил что-то дополнительное, думаю это поможет избежать конфликтов
 




https://hub.docker.com/r/e2754/marat-netology