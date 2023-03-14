# Домашнее задание к занятию `13.3. «Защита сети»` - `Алаев Марат`


### Задание 1

Проведите разведку системы и определите, какие сетевые службы запущены на защищаемой системе:

sudo nmap -sA < ip-адрес >

sudo nmap -sT < ip-адрес >

sudo nmap -sS < ip-адрес >

sudo nmap -sV < ip-адрес >

По желанию можете поэкспериментировать с опциями: https://nmap.org/man/ru/man-briefoptions.html.

В качестве ответа пришлите события, которые попали в логи Suricata и Fail2Ban, прокомментируйте результат.

___

suricata:

12/2023-21:03:52.371340  [**] [1:2010939:3] ET SCAN Suspicious inbound to PostgreSQL port 5432 [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 192.168.61.141:46374 -> 192.168.61.128:5432

03/12/2023-21:03:52.405714  [**] [1:2024364:4] ET SCAN Possible Nmap User-Agent Observed [**] [Classification: Web Application Attack] [Priority: 1] {TCP} 192.168.61.141:40556 -> 192.168.61.128:8080

suricata распознал ip, протокол, порт с которого пришло соединение и так же программу с помощью которой пришли запросы



fail2ban:

Mar 12 22:33:46 ubuntu sshd[29885]: Unable to negotiate with 192.168.61.141 port 45194: no matching host key type found. Their offer: ssh-dss [preauth]

Mar 12 22:33:47 ubuntu sshd[29889]: Connection closed by 192.168.61.141 port 45206 [preauth]

fail2ban заметил запросы на ssh порт и то что аутентификация не была завершена 
а был разрыв соединения



### Задание 2

Проведите атаку на подбор пароля для службы SSH:

hydra -L users.txt -P pass.txt < ip-адрес > ssh

Настройка hydra:

+ создайте два файла: users.txt и pass.txt;
+ в каждой строчке первого файла должны быть имена пользователей, второго — пароли. В нашем случае это могут быть случайные строки, но ради эксперимента можете добавить имя и пароль существующего пользователя.
Дополнительная информация по hydra: https://kali.tools/?p=1847.

Включение защиты SSH для Fail2Ban:

+ открыть файл /etc/fail2ban/jail.conf,
+ найти секцию ssh,
+ установить enabled в true.
Дополнительная информация по Fail2Ban:https://putty.org.ru/articles/fail2ban-ssh.html.

В качестве ответа пришлите события, которые попали в логи Suricata и Fail2Ban, прокомментируйте результат.

___

suricata:

SURICATA STREAM excessive retransmissions [**] [Classification: Generic Protocol Command Decode] [Priority: 3] {TCP} 192.168.61.141:42610 -> 192.168.61.128:22

03/12/2023-23:06:17.399398  [**] [1:2003068:7] ET SCAN Potential SSH Scan OUTBOUND [**] [Classification: Attempted Information Leak] [Priority: 2] {TCP} 192.168.61.141:42736 -> 192.168.61.128:22

suricata определил, что было множественное кол-во запросов на 22 и то что это целенаправленное сканирование ssh



fail2ban:

2023-03-12 22:54:35,302 fail2ban.filter         [28996]: INFO    [sshd] Found 192.168.61.141 
2023-03-12 22:54:35,361 fail2ban.actions        [28996]: NOTICE  [sshd] Ban 192.168.61.141

fail2ban обнаружил множественные попытки подключиться по ssh и забанил ip с которого были совершены эти попытки 

