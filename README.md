# Домашнее задание к занятию `13.1. «Уязвимости и атаки на информационные системы»` - `Алаев Марат`


### Задание 1

Скачайте и установите виртуальную машину Metasploitable: https://sourceforge.net/projects/metasploitable/.

Это типовая ОС для экспериментов в области информационной безопасности, с которой следует начать при анализе уязвимостей.

Просканируйте эту виртуальную машину, используя nmap.

Попробуйте найти уязвимости, которым подвержена эта виртуальная машина.

Сами уязвимости можно поискать на сайте https://www.exploit-db.com/.

Для этого нужно в поиске ввести название сетевой службы, обнаруженной на атакуемой машине, и выбрать подходящие по версии уязвимости.

Ответьте на следующие вопросы:

+ Какие сетевые службы в ней разрешены?
+ Какие уязвимости были вами обнаружены? (список со ссылками: достаточно трёх уязвимостей)
Приведите ответ в свободной форме.

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

На сервере установлен vsftpd 2.3.4
+ vsftpd 2.3.4 - Backdoor Command Execution https://www.exploit-db.com/exploits/49757

На серевере установлен BIND 9.4.2
+ BIND 9.4.1 < 9.4.2 - Remote DNS Cache Poisoning (Metasploit) https://www.exploit-db.com/exploits/6122





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

