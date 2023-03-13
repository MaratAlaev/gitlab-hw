# Домашнее задание к занятию `12.09. «Базы данных в облаке»` - `Алаев Марат`


### Задание 1

В качестве результата вашей работы пришлите скриншоты:

1) Созданной базы данных; 2) Результата вывода команды на реплике select * from test_table;.


![image](https://user-images.githubusercontent.com/46092593/224781766-e05fa2c3-7b79-4c0d-8fc7-003998f9aeee.png)


![image](https://user-images.githubusercontent.com/46092593/224781869-27679563-c7e4-4bd7-acbf-eaedcbf83de6.png)




### Задание 2

Создайте кластер, как в задании 1 с помощью Terraform.

В качестве результата вашей работы пришлите скришоты:

1) Скриншот созданной базы данных. 2) Код Terraform, создающий базу данных.

![image](https://user-images.githubusercontent.com/46092593/224782031-60fbdc81-1667-4af1-b06e-228da3a6bac0.png)

```terraform
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-c"
}

resource "yandex_mdb_postgresql_cluster" "mypg" {
  name        = "mypg"
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.mynet.id


  config {
    version = "12"
	
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = "10"
    }
	
	  postgresql_config = {
      max_connections                   = 395
	    max_locks_per_transaction = 250
	    join_collapse_limit = 200
	    from_collapse_limit = 100
	    synchronous_commit = "SYNCHRONOUS_COMMIT_OFF"
    }
  }
  
  database {
    name  = "db1"
    owner = "marat"
	  lc_collate="ru_RU.UTF-8"
	  lc_type="ru_RU.UTF-8"
  }

  user {
    name     = "marat"
    password = "12341234"
    permission {
      database_name = "db1"
    }
  }

  host {
    zone      = "ru-central1-c"
    subnet_id = yandex_vpc_subnet.pg-c.id
    assign_public_ip = true
  }

  host {
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.pg-a.id
    assign_public_ip = true
  }
}

resource "yandex_vpc_network" "mynet" {
  name = "mynet"
}

resource "yandex_vpc_subnet" "pg-c" {
  name           = "pg-c"
  zone      = "ru-central1-c"
  network_id     = yandex_vpc_network.mynet.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}

resource "yandex_vpc_subnet" "pg-a" {
  name           = "pg-a"
  zone      = "ru-central1-a"
  network_id     = yandex_vpc_network.mynet.id
  v4_cidr_blocks = ["10.6.0.0/24"]
}
```
