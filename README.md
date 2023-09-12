# Домашнее задание к занятию «Использование Terraform в команде» - Марат Алаев

### Задание 1

1. Возьмите код:
- из [ДЗ к лекции 4](https://github.com/netology-code/ter-homeworks/tree/main/04/src),
- из [демо к лекции 4](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1).
2. Проверьте код с помощью tflint и checkov. Вам не нужно инициализировать этот проект.
3. Перечислите, какие **типы** ошибок обнаружены в проекте (без дублей).

------

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/1c2e6535-2cc4-48d4-928d-cb1fdf28e663)


![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/4533a223-eaee-4c48-a5c8-99053e196764)


![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/f16ffa58-93ff-4db3-8700-1c8a1e7b14ff)


![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/48e3cd97-3038-47d6-9d67-3d1e9524e4e9)


### Задание 2

1. Возьмите ваш GitHub-репозиторий с **выполненным ДЗ 4** в ветке 'terraform-04' и сделайте из него ветку 'terraform-05'.
2. Повторите демонстрацию лекции: настройте YDB, S3 bucket, yandex service account, права доступа и мигрируйте state проекта в S3 с блокировками. Предоставьте скриншоты процесса в качестве ответа.
3. Закоммитьте в ветку 'terraform-05' все изменения.
4. Откройте в проекте terraform console, а в другом окне из этой же директории попробуйте запустить terraform apply.
5. Пришлите ответ об ошибке доступа к state.
6. Принудительно разблокируйте state. Пришлите команду и вывод.


------

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/a42f0b11-bfd9-4417-b204-c867affaf453)



![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/1897dedc-dae2-4d64-aa09-e4a024fb5618)



![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/84735032-67c3-49b7-bf75-877e06bf6bde)



![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/27890f3e-6857-4d37-b4f5-ea0beaeaddde)


### Задание 3  

1. Сделайте в GitHub из ветки 'terraform-05' новую ветку 'terraform-hotfix'.
2. Проверье код с помощью tflint и checkov, исправьте все предупреждения и ошибки в 'terraform-hotfix', сделайте коммит.
3. Откройте новый pull request 'terraform-hotfix' --> 'terraform-05'. 
4. Вставьте в комментарий PR результат анализа tflint и checkov, план изменений инфраструктуры из вывода команды terraform plan.
5. Пришлите ссылку на PR для ревью. Вливать код в 'terraform-05' не нужно.

------

https://github.com/MaratAlaev/gitlab-hw/pull/1


### Задание 4

1. Напишите переменные с валидацией и протестируйте их, заполнив default верными и неверными значениями. Предоставьте скриншоты проверок из terraform console. 

- type=string, description="ip-адрес" — проверка, что значение переменной содержит верный IP-адрес с помощью функций cidrhost() или regex(). Тесты:  "192.168.0.1" и "1920.1680.0.1";
- type=list(string), description="список ip-адресов" — проверка, что все адреса верны. Тесты:  ["192.168.0.1", "1.1.1.1", "127.0.0.1"] и ["192.168.0.1", "1.1.1.1", "1270.0.0.1"].

------

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/d9874377-4a1d-490a-8163-df7da4106ba3)


![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/e47f179e-e1ff-4086-9667-39a5e49dc49b)



![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/a72276e6-9031-4d52-a0a5-ab5a3ee9261b)


![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/6d613fcd-c210-4a1f-9a13-380988d1b521)


