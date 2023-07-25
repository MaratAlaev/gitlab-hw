# Домашнее задание к занятию `Введение в Terraform` - `Алаев Марат`

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/5d225e01-c1bc-49a7-9ce4-4bb6380e0096)


## Задание 1

1. Перейдите в каталог [**src**](https://github.com/netology-code/ter-homeworks/tree/main/01/src). Скачайте все необходимые зависимости, использованные в проекте. 
2. Изучите файл **.gitignore**. В каком terraform файле согласно этому .gitignore допустимо сохранить личную, секретную информацию?
3. Выполните код проекта. Найдите  в State-файле секретное содержимое созданного ресурса **random_password**, пришлите в качестве ответа конкретный ключ и его значение.
4. Раскомментируйте блок кода, примерно расположенный на строчках 29-42 файла **main.tf**.
Выполните команду ```terraform validate```. Объясните в чем заключаются намеренно допущенные ошибки? Исправьте их.
5. Выполните код. В качестве ответа приложите вывод команды ```docker ps```
6. Замените имя docker-контейнера в блоке кода на ```hello_world```. Не перепутайте имя контейнера и имя образа. Мы все еще продолжаем использовать name = "nginx:latest"! Выполните команду ```terraform apply -auto-approve```.
Объясните своими словами, в чем может быть опасность применения ключа  ```-auto-approve``` ? В качестве ответа дополнительно приложите вывод команды ```docker ps```
8. Уничтожьте созданные ресурсы с помощью **terraform**. Убедитесь, что все ресурсы удалены. Приложите содержимое файла **terraform.tfstate**. 
9. Объясните, почему при этом не был удален docker образ **nginx:latest** ? Ответ подкрепите выдержкой из документации **провайдера docker**.

___

2. в personal.auto.tfvars
3. "result": "P351LgkfIRShSTZ6"
4. resource "docker_image" "nginx" - тут надо было передать название 
random_password.random_string.result - поправил название переменной
5. ![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/6cae61e3-fa32-4c59-ab82-265e7cbf385c)
6. -auto-approve убирает сопоставление с инфраструктурой и может не обнаружить ошибок, что может привести к уничтожению всей инфраструктуры
7. ![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/78304c63-503b-4120-9714-cd8b71b739ee)
8. ![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/577bb011-2d81-47d9-aa2e-8539f4c57262)
9. если свойство keep_locally установлено true то образ не удаляется при destroy


## Задание 2

1. Изучите в документации provider [**Virtualbox**](https://docs.comcloud.xyz/providers/shekeriev/virtualbox/latest/docs) от 
shekeriev.
2. Создайте с его помощью любую виртуальную машину. Чтобы не использовать VPN советуем выбрать любой образ с расположением в github из [**списка**](https://www.vagrantbox.es/)

В качестве ответа приложите plan для создаваемого ресурса и скриншот созданного в VB ресурса.  

___

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/4e8439e6-a1d9-4d82-accf-0021873e4c2d)


![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/e1da7b0d-b343-4585-8ab8-5503729c9a6a)




