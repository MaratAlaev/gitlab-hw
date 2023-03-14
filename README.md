# Домашнее задание к занятию `13.2. «Защита хоста»` - `Алаев Марат`


### Задание 1

Установите eCryptfs.

Добавьте пользователя cryptouser.

Зашифруйте домашний каталог пользователя с помощью eCryptfs.

В качестве ответа пришлите снимки экрана домашнего каталога пользователя с исходными и зашифрованными данными.

___

какие сетевые службы на ней разрешены:

+ FTP
+ SSH
+ telnet
+ smtp
+ http
+ rpcbind
+ exec
+ login
+ tcpwrapped
+ java-rmi
+ bindshell
+ nfs
+ ftp
+ mysql
+ postgresql

уязвимости:

На сервере установлен OpenSSH 4.7 

+ OpenSSH 2.3 < 7.7 - Username Enumeration https://www.exploit-db.com/exploits/45233
+ OpenSSH < 7.4 - agent Protocol Arbitrary Library Loading
https://www.exploit-db.com/exploits/40963

На сервере установлен Apache 2.2.8
+ Apache < 1.3.37/2.0.59/2.2.3 mod_rewrite - Remote Overflow
https://www.exploit-db.com/exploits/2237



### Задание 2

Проведите сканирование Metasploitable в режимах SYN, FIN, Xmas, UDP.

Запишите сеансы сканирования в Wireshark.

Ответьте на следующие вопросы:

+ Чем отличаются эти режимы сканирования с точки зрения сетевого трафика?
+ Как отвечает сервер?

Приведите ответ в свободной форме.

___

SYN - отправляет пакет SYN, а в ответ получает RST и RST/ACK
FIN - отправляет пакет ACK, а в ответ получает RST
Xmas - отправляет пакет FIN/PSH/URG, а в ответ получает RST/ACK
UDP - отправляет UDP пакет, в ответ получает ICMP
