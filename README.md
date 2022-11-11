# Домашнее задание к занятию `9.2. Zabbix. Часть 1` - `Алаев Марат`

### Задание 1


[Cкриншот к заданию 1](https://github.com/MaratAlaev/gitlab-hw/blob/9.2-Zabbix/img/92-1.png)


```bash
wget https://repo.zabbix.com/zabbix/6.0/ubuntu-arm64/pool/main/z/zabbix-release/zabbix-release_6.0-5%2Bubuntu20.04_all.deb
dpkg -i zabbix-release_6.0-5+ubuntu20.04_all.deb
apt update

apt install zabbix-server-pgsql zabbix-frontend-php php7.4-pgsql zabbix-nginx-conf zabbix-sql-scripts zabbix-agent

sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix

zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
```


### Задание 2


# Скриншоты к заданию 2

[1:](https://github.com/MaratAlaev/gitlab-hw/blob/9.2-Zabbix/img/92-2.png)

[2:](https://github.com/MaratAlaev/gitlab-hw/blob/9.2-Zabbix/img/92-2-2.png)

[3:](https://github.com/MaratAlaev/gitlab-hw/blob/9.2-Zabbix/img/92-2-3.png)


```bash
sudo apt install zabbix-agent
sudo nano /etc/zabbix/zabbix_agentd.conf
sudo systemctl restart zabbix-agent.service 
```


### Задание 3

[Cкриншот к заданию 3](https://github.com/MaratAlaev/gitlab-hw/blob/9.2-Zabbix/img/92-3.png)