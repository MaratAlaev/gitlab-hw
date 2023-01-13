# Домашнее задание к занятию `10.7 «Отказоустойчивость в облаке»` - `Алаев Марат`


### Задание 1


```
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  zone = "ru-central1-a"
}

resource "yandex_compute_instance" "vm" {
  count = 2

  name = "test-${count.index}"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8kb72eo1r5fs97a1ki"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install nginx -y"]
  }

  connection {
    host        = self.network_interface.0.nat_ip_address
    type        = "ssh"
    user        = "terruser"
    private_key = file(var.ssh_key_private)
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_lb_target_group" "targetgroup" {
  name      = "my-target-group"
  region_id = "ru-central1"

  target {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    address   = "${yandex_compute_instance.vm[0].network_interface.0.ip_address}"
  }

  target {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    address   = "${yandex_compute_instance.vm[1].network_interface.0.ip_address}"
  }
}

resource "yandex_lb_network_load_balancer" "loadbalancer" {
  name = "load-balancer"

  listener {
    name = "listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_lb_target_group.targetgroup.id}"

    healthcheck {
      name = "http"
      http_options {
        port = 80
      }
    }
  }
}
```

[Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/10.7_FailSafeInCloud/img/10-7-1-1.png)


[Cкриншот 2](https://github.com/MaratAlaev/gitlab-hw/blob/10.7_FailSafeInCloud/img/10-7-1-2.png)


[Cкриншот 3](https://github.com/MaratAlaev/gitlab-hw/blob/10.7_FailSafeInCloud/img/10-7-1-3.png)



### Задание 2


```
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  zone = "ru-central1-a"
}

resource "yandex_compute_instance_group" "ig-1" {
  name               = "with-balancer"
  folder_id          = "b1gamifnjr6h49otdp48"
  service_account_id = "ajemk29m97hsrlbmbqe4"

  instance_template {
    platform_id = "standard-v3"
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd8kb72eo1r5fs97a1ki"
      }
    }

    network_interface {
      network_id = "${yandex_vpc_network.network-1.id}"
      nat = true
      subnet_ids = ["${yandex_vpc_subnet.subnet-1.id}"]
    }

    metadata = {
      ssh-keys = "terruser:${file(var.ssh_key_private)}"
      user-data = file("./metadata.yaml")
    }
  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  load_balancer {
    target_group_name        = "target-group"
    target_group_description = "load balancer target group"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.network-1.id}"
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_lb_network_load_balancer" "loadbalancer" {
  name = "load-balancer"

  listener {
    name = "listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_compute_instance_group.ig-1.load_balancer.0.target_group_id}"

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
```


[Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/10.7_FailSafeInCloud/img/10-7-2-1.png)


[Cкриншот 2](https://github.com/MaratAlaev/gitlab-hw/blob/10.7_FailSafeInCloud/img/10-7-2-2.png)