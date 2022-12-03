# Домашнее задание к занятию `10.1. Keepalived/vrrp` - `Алаев Марат`

### Задание 1

MASTER:

```
vrrp_instance test {
state MASTER
interface ens33
virtual_router_id 10
priority 110
#advert_int 4
authentication {
auth_type AH
auth_pass test
}

unicast_peer {
192.168.61.128
}

virtual_ipaddress {
192.168.61.31  dev ens33 label ens33:vip
}
}
```


BACKUP:

```
vrrp_instance test {
state BACKUP
interface ens33
virtual_router_id 10
priority 100
#advert_int 4
authentication {
auth_type AH
auth_pass test
}

unicast_peer {
192.168.61.141
}

virtual_ipaddress {
192.168.61.31  dev ens33 label ens33:vip
}
}
```



[1 Скриншот](https://github.com/MaratAlaev/gitlab-hw/blob/Keepalived/img/1-1.png)


[2 Скриншот](https://github.com/MaratAlaev/gitlab-hw/blob/Keepalived/img/1-2.png)

### Задание 2

до отключения мастера:

[1 Скриншот](https://github.com/MaratAlaev/gitlab-hw/blob/Keepalived/img/2-1.png)



после отключения мастера: 

[2 Скриншот](https://github.com/MaratAlaev/gitlab-hw/blob/Keepalived/img/2-2.png)