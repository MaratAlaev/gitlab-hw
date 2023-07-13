# Домашнее задание к занятию `Elasticsearch` - `Алаев Марат`


### Задача 1

В этом задании вы потренируетесь в:

- установке Elasticsearch,
- первоначальном конфигурировании Elasticsearch,
- запуске Elasticsearch в Docker.

Используя Docker-образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для Elasticsearch,
- соберите Docker-образ и сделайте `push` в ваш docker.io-репозиторий,
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины.

Требования к `elasticsearch.yml`:

- данные `path` должны сохраняться в `/var/lib`,
- имя ноды должно быть `netology_test`.

В ответе приведите:

- текст Dockerfile-манифеста,
- ссылку на образ в репозитории dockerhub,
- ответ `Elasticsearch` на запрос пути `/` в json-виде.

Подсказки:

- возможно, вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum,
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml,
- при некоторых проблемах вам поможет Docker-директива ulimit,
- Elasticsearch в логах обычно описывает проблему и пути её решения.

Далее мы будем работать с этим экземпляром Elasticsearch.

___
```dockerfile
FROM centos:centos7

RUN yum -y install wget

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.8.2-linux-x86_64.tar.gz
RUN tar -xzf elasticsearch-8.8.2-linux-x86_64.tar.gz 
RUN rm elasticsearch-8.8.2-linux-x86_64.tar.gz 

RUN mkdir /var/lib/logs_elastic
RUN mkdir /var/lib/data_elastic

RUN echo -e "cluster.name: netology_test\n\ 
network.host: 0.0.0.0\n\
node.name: master\n\
path.data: /var/lib/data_elastic\n\
path.logs: /var/lib/logs_elastic\n\
discovery.seed_hosts: 127.0.0.1\n\
cluster.initial_master_nodes: [\"master\"]\n\
xpack.security.enabled: false\n\
xpack.security.enrollment.enabled: false\n\
xpack.security.http.ssl:\n\
  enabled: false" > /elasticsearch-8.8.2/config/elasticsearch.yml


RUN useradd -ms /bin/bash elasticsearch

RUN chown -R elasticsearch:elasticsearch /elasticsearch-8.8.2/
RUN chown -R elasticsearch:elasticsearch /var/lib/logs_elastic/
RUN chown -R elasticsearch:elasticsearch /var/lib/data_elastic/

USER elasticsearch

EXPOSE 9200 9300

ENTRYPOINT [ "/elasticsearch-8.8.2/bin/elasticsearch"]
```


https://hub.docker.com/repository/docker/e2754/marat_elasticsearch версия 0.0.2

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/e3ff4924-5495-422e-8a72-d707fc684e42)


### Задача 2
В этом задании вы научитесь:

- создавать и удалять индексы,
- изучать состояние кластера,
- обосновывать причину деградации доступности данных.

Ознакомьтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `Elasticsearch` 3 индекса в соответствии с таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

Получите список индексов и их статусов, используя API, и **приведите в ответе** на задание.

Получите состояние кластера `Elasticsearch`, используя API.

Как вы думаете, почему часть индексов и кластер находятся в состоянии yellow?

Удалите все индексы.

**Важно**

При проектировании кластера Elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

___

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/9c477125-db2e-4d40-905c-1387a5748395)

статус yellow связан с количеством реплик.
elasticsearch, не будет назначать реплики на одну ноду с основным шардом




### Задача 3

В этом задании вы научитесь:

- создавать бэкапы данных,
- восстанавливать индексы из бэкапов.

Создайте директорию `{путь до корневой директории с Elasticsearch в образе}/snapshots`.

Используя API, [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
эту директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `Elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshot`.

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `Elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

Подсказки:

- возможно, вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `Elasticsearch`.

___

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/3e73459c-ce50-4fb1-a8f1-b4b364eba968)

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/597ee022-0579-46a2-90c4-b3c8af142e78)

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/68b06e11-adde-46a0-9e4e-56fb44a8ec40)
