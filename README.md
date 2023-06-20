# Домашнее задание к занятию `Типы и структура СУБД` - `Алаев Марат`


### Задача 1

Архитектор ПО решил проконсультироваться у вас, какой тип БД лучше выбрать для хранения определённых данных.
Он вам предоставил следующие типы сущностей, которые нужно будет хранить в БД:

- электронные чеки в json-виде,
склады и автомобильные дороги для логистической компании,
- генеалогические деревья,
- кэш идентификаторов клиентов с ограниченным временем жизни для движка аутентификации,
- отношения клиент-покупка для интернет-магазина.

Выберите подходящие типы СУБД для каждой сущности и объясните свой выбор.

___

- тут подойдет документо-ориентированная СУБД 
так как чеки могут различаться от чека к чеку 
и кол-во полей может изменяться, документо-ориентированная СУБД позволяет хранить разнообразное кол-во ключей от документа к документу


- думаю тут удобно будет использовать реляционные СУБД 
так как данные уже определены и различаться типы не будут


- тут лучше будет использовать графовые СУБД, так как такой тип баз как раз и предназначен для хранения взаимосвязей 


- тут отлично подойдут СУБД ключ-значение, так как удобно можно хранить пользователь + его кеш аутентификатор, также можно задать время на удаление записи


- думаю тут подойдут базы которые соответствуют требованиям ACID
для надежного выполнения транзакций


### Задача 2
Вы создали распределённое высоконагруженное приложение и хотите классифицировать его согласно CAP-теореме. Какой классификации по CAP-теореме соответствует ваша система, если (каждый пункт — это отдельная реализация вашей системы и для каждого пункта нужно привести классификацию):

- данные записываются на все узлы с задержкой до часа (асинхронная запись);
- при сетевых сбоях система может разделиться на 2 раздельных кластера;
- система может не прислать корректный ответ или сбросить соединение.

Согласно PACELC-теореме как бы вы классифицировали эти реализации?

___

- PA/EC (система не гарантирует целостность данных при такой задержке но исходя из CAP теоремы, гарантирует доступность и распределенность, но по теореме PACELC, большая задержка в один час говрит о EC) 
- CA/EL (данные в кластере согласованы и доступны, но не устойчивы к разделению, не имеют большой задержки)
- PC/EL (все данные в кластере целостные и устойчивы к распределению, но доступность идет в ущерб, задержки нет, но может просто не прийти ответ)





### Задача 3
Могут ли в одной системе сочетаться принципы BASE и ACID? Почему?

___

не могут, так как эти принципы противопоставляемые 


### Задача 4
Вам дали задачу написать системное решение, основой которого бы послужили:

- фиксация некоторых значений с временем жизни,
- реакция на истечение таймаута.

Вы слышали о key-value-хранилище, которое имеет механизм Pub/Sub. Что это за система? Какие минусы выбора этой системы?

___

key-value хранилище которое  имеет механизм Pub/Sub 
скорее всего речь идет о Redis, который имеет у себя такой механизм 
это механизм который позволяет подписаться на определенный канал и получать 
данные только от него, то есть рассылка определенных данных будет происходить по принципу все подписчики получают данные от канала на который подписаны 

из минусов, есть проблема в том что pub/sub не гарантирует доставку сообщений 
что является большим минусом для систем котрым важна консистентность

так же во время работы Redis хранит данные в оперативной памяти 
и врямя от времени делает слепки на жесткий диск 
и если работа redis будет прервана то это приведет к частичной потери данных 
