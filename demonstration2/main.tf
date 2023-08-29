terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

locals{
  ssh_keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
}

variable "list_resources_vm" {
  type = list(object({ vm_name=string, cpu=number, ram=number,core_fraction=number ,nat=bool }))
  default = [ 
  {
    vm_name = "main",
    cpu     = 2,
    ram     = 1,
    core_fraction = 5,
    nat     = true
  },
  {
    vm_name = "replica",
    cpu     = 2,
    ram     = 1,
    core_fraction = 20,
    nat     = true
  } 
 ]
}

#создаем облачную сеть
resource "yandex_vpc_network" "develop" {
  name = "develop"
}

#создаем подсеть
resource "yandex_vpc_subnet" "develop" {
  name           = "develop-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

#считываем данные об образе ОС
data "yandex_compute_image" "ubuntu-2004-lts" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "databases" {
  for_each = {
    for index, vm in var.list_resources_vm:
    vm.vm_name => vm
  }
  name = "netology-develop-${each.value.vm_name}"
  platform_id = var.vm_web_platform_id
  
  resources {
    cores = each.value.cpu
    memory = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
   initialize_params {
    image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
   }
  }

  network_interface {
    security_group_ids = [yandex_vpc_security_group.example.id]
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = each.value.nat
  }

  metadata = {
    ssh-keys = local.ssh_keys
  }
}

resource "yandex_compute_disk" "disk" {
  count = 3
  name  = "disk-${count.index}"
  size  = 1
  zone  = var.default_zone
}

resource "yandex_compute_instance" "storage" {
  count = 1
  name = "storage-vm"
  platform_id = var.vm_web_platform_id
  
  resources {
    cores = 2
    memory = 2
    core_fraction = 5
  }

  boot_disk {
   initialize_params {
    image_id =  data.yandex_compute_image.ubuntu-2004-lts.image_id
   }
  }

  dynamic "secondary_disk"{
    for_each  = yandex_compute_disk.disk
    content {
      disk_id = lookup(secondary_disk.value, "id", null)
    }
  }

  network_interface {
    security_group_ids = [yandex_vpc_security_group.example.id]
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    ssh-keys = local.ssh_keys
  }
}

#создаем 2 идентичные ВМ
resource "yandex_compute_instance" "webservers" {
  name        = "netology-develop-platform-web-${count.index}"
  platform_id = "standard-v1"
  
  count = 2

  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type = "network-hdd"
      size = 5
    }   
  }

  metadata = {
    ssh-keys = local.ssh_keys
  }

  scheduling_policy { preemptible = true }

  network_interface { 
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true
}


resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",

    { webservers =  yandex_compute_instance.webservers, storage = yandex_compute_instance.storage ,databases = yandex_compute_instance.databases  }  )

  filename = "${abspath(path.module)}/hosts.cfg"
}


resource "null_resource" "web_hosts_provision" {
#Ждем создания инстанса
depends_on = [yandex_compute_instance.webservers]

#Добавление ПРИВАТНОГО ssh ключа в ssh-agent
  provisioner "local-exec" {
    command = "cat ~/.ssh/id_rsa | ssh-add -"
  }

#Костыль!!! Даем ВМ 60 сек на первый запуск. Лучше выполнить это через wait_for port 22 на стороне ansible
# В случае использования cloud-init может потребоваться еще больше времени
 provisioner "local-exec" {
    command = "sleep 60"
  }

#Запуск ansible-playbook
  provisioner "local-exec" {                  
    command  = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml"
    on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    #срабатывание триггера при изменении переменных
  }
    triggers = {  
      always_run         = "${timestamp()}" #всегда т.к. дата и время постоянно изменяются
      playbook_src_hash  = file("${abspath(path.module)}/test.yml") # при изменении содержимого playbook файла
      ssh_public_key     = var.public_key # при изменении переменной
    }

}
