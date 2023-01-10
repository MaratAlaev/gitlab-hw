# Домашнее задание к занятию `10.2 Кластеризация` - `Алаев Марат`


### Задание 1

Основное различие в том, что у MPP разделенная физическая память 
а у SMP общая


### Задание 2

Сильно связанные системы состоят из однородных процессоров и общей памяти 
В то время как в слабо связанных память распределяется на все процессоры 


### Задание 3

абсолютная масштабируемость

нет ограничений на размер узлов и кластеров

наращиваемая масштабируемость

можно расширять узлы по необходимости

высокий коэффициент готовности

отказоустойчивость, благодаря автономности узлов

соотношение цена/производительность

можно строить кластер из любых строительных блоков: чем
проще и стандартнее блоки, тем дешевле обходится
вычислительная мощност


### Задание 4

Кластеры высокой доступности 

Кластеры с балансировкой нагрузки

Вычислительные кластеры

Системы распределенных вычислений


### Задание 5

Kafka используется в микросервисах 
для связи сервисов между собой 

rabitMQ используется в системах где требуется гарантированная доставка сообщений 
нам не нужно больше планировать архитектуру так чтобы каждый компонент передавал данные другим компонентам 
с помощью брокера, можно наладить передачу сообщений одному и более компанентам


### Задание 6

[Cкриншот к заданию 6](https://github.com/MaratAlaev/gitlab-hw/blob/10.2_Кластеризация/img/10-2-6.png)

3 узла RabbitMQ - их кол-во можно изменить
3 сети докеров - чтобы иметь возможность моделировать разделение сети
1 узел HAProxy - для балансировки нагрузки на запрос и для защиты от сбоев
1 сеть по умолчанию - для соединения с узлами через HAProxy


Балансировка нагрузки
Отказ узла
Разделение сети