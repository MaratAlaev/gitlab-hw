# Домашнее задание к занятию `Введение в виртуализацию. Типы и функции гипервизоров. Обзор рынка вендоров и областей применения` - `Алаев Марат`


### Задача 1

Опишите кратко, в чём основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.

___

Аппаратная виртуализация - это самая низкоуровневая виртуализация которая никак не зависит от ОС хоста, обладает самой высокой производительность  так как работают с железом напрямую, без прослойки процессов в хостовой ОС

паравиртуализация уже в отличии от аппаратной, зависит от операционной системы хоста, так как не напрямую общается с железом, а через прослойку хостовой ОС

в случае  виртуализации на основе ОС, в случае такой виртуализации мы не можем использовать ОС ядро которых отличаются от хостовой, тот же Docker Desktop работает через прослойку в виде WSL, чтобы запускать Linux контейнеры


### Задача 2
Выберите один из вариантов использования организации физических серверов в зависимости от условий использования.
Организация серверов:

1)физические сервера,

2)паравиртуализация,

3)виртуализация уровня ОС.

Условия использования:
1)высоконагруженная база данных, чувствительная к отказу;
2) различные web-приложения;
3)Windows-системы для использования бухгалтерским отделом;
4)системы, выполняющие высокопроизводительные расчёты на GPU.

Опишите, почему вы выбрали к каждому целевому использованию такую организацию.

___

1)высоконагруженная база данных, чувствительная к отказу - думаю тут лучше будет использовать отдельную связку физических серверов с настроенной репликаций
так как тут нужна надежность 


2)различные web-приложения - лучше будет запускать на уровне виртуализации ОС
это позволит быстро разворачивать web приложения, а также уберет возможные проблемы связанные с зависимостями 



3)Windows-системы для использования бухгалтерским отделом - тут лучше использовать паравиртуализацию, на приватном офисном сервере, так как это даст надежность сохранности данных + у нас не будет зависимости от ядра ОС и не будет все забито на одной физической машине, это упростить администрирование этих серверов  



4)системы, выполняющие высокопроизводительные расчёты на GPU - думаю тут лучше всего использовать физические сервера, так как в других случаях будет потеря производительности 





### Задача 3
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

### Задача 4
Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.

___

из собственного опыта рекомендую так не делать 
так как например часто встречался с конфликтами между Vmware и virtualbox
так как иногда, одно из-за друго ломается, что потом приходится чинить 
плюс еще WSL из-за этого то работает то нет 

вообщем не рекомендую, лучше разделить машины в таком случае 

ну если возможности нет, я бы включил поддержку виртуализации в самой VM 
и там бы запустил что-то дополнительное, думаю это поможет избежать конфликтов
 


