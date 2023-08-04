# Домашнее задание к занятию `Основы Terraform. Yandex Cloud` - `Алаев Марат`


### Задание 1
В качестве ответа всегда полностью прикладывайте ваш terraform-код в git.

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Переименуйте файл personal.auto.tfvars_example в personal.auto.tfvars. Заполните переменные: идентификаторы облака, токен доступа. Благодаря .gitignore этот файл не попадёт в публичный репозиторий. **Вы можете выбрать иной способ безопасно передать секретные данные в terraform.**
3. Сгенерируйте или используйте свой текущий ssh-ключ. Запишите его открытую часть в переменную **vms_ssh_root_key**.
4. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
5. Ответьте, как в процессе обучения могут пригодиться параметры ```preemptible = true``` и ```core_fraction=5``` в параметрах ВМ. Ответ в документации Yandex Cloud.

В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ;
- скриншот успешного подключения к консоли ВМ через ssh. К OS ubuntu необходимо подключаться под пользователем ubuntu: "ssh ubuntu@vm_ip_address";
- ответы на вопросы.

___

платформа standard-v4 не существует

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/90fccd21-34ff-4722-aa74-98a04d899dd9)

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/f50f777b-77c9-450e-9cae-7cdcf060f659)

preemptible = true, прерываемая виртуальная машина, во первых такие машины дешевле, что помогает экономить деньги во время обучения, а также если мы случайно забудет уничтожить ее, то она через 24 часа выключится 
для обучения самое то, в проде лучше не использовать 


core_fraction = 5, указывает в процентах, ограничение потребления ресурсов процессора, уменьшает стоимость машины и экономит деньги, но растут задержки, от чего такое не стоит использовать на высоконагруженных машинах 


### Задание 2

1. Изучите файлы проекта.
2. Замените все хардкод-**значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на **отдельные** переменные. К названиям переменных ВМ добавьте в начало префикс **vm_web_** .  Пример: **vm_web_name**.
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их **default** прежними значениями из main.tf. 
3. Проверьте terraform plan. Изменений быть не должно. 

___
```terraform
variable "vm_web_image_name" {
  type = string
  default = "ubuntu-2004-lts"
  description = "name image"
}

variable "vm_web_name_instance" {
   type = string
   default = "netology-develop-platform-web"
   description = "name instance"
}

variable "vm_web_platform_id" {
  type = string
  default = "standard-v1"
  description = "platform_id"
}

variable "vm_web_cores" {
  type = number
  default = 2
  description = "count cores"
}

variable "vm_web_memory" {
  type = number
  default = 1
  description = "size memory"
}

variable "vm_web_core_fraction" {
  type = number
  default = 5
  description = "fraction cpu core"
}

variable "vm_web_scheduling_policy_preemptible" {
  type = bool
  default = true
  description = "enabled preemptible"
}

variable "vm_web_network_interface_nat" {
  type = bool
  default = true
  description = "enable nat"
}

variable "vm_web_serial_port_enable" {
  type = number
  default = 1
  description = "count enable port"
}
```

### Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: **"netology-develop-platform-db"** ,  cores  = 2, memory = 2, core_fraction = 20. Объявите её переменные с префиксом **vm_db_** в том же файле ('vms_platform.tf').
3. Примените изменения. 

___


```terraform
###vm_web

variable "vm_web_image_name" {
  type = string
  default = "ubuntu-2004-lts"
  description = "name image"
}

variable "vm_web_name_instance" {
   type = string
   default = "netology-develop-platform-web"
   description = "name instance"
}

variable "vm_web_platform_id" {
  type = string
  default = "standard-v1"
  description = "platform_id"
}

variable "vm_web_cores" {
  type = number
  default = 2
  description = "count cores"
}

variable "vm_web_memory" {
  type = number
  default = 1
  description = "size memory"
}

variable "vm_web_core_fraction" {
  type = number
  default = 5
  description = "fraction cpu core"
}

variable "vm_web_scheduling_policy_preemptible" {
  type = bool
  default = true
  description = "enabled preemptible"
}

variable "vm_web_network_interface_nat" {
  type = bool
  default = true
  description = "enable nat"
}

variable "vm_web_serial_port_enable" {
  type = number
  default = 1
  description = "count enable port"
}

### vm_db

variable "vm_db_image_name" {
  type = string
  default = "ubuntu-2004-lts"
  description = "name image"
}

variable "vm_db_name_instance" {
   type = string
   default = "netology-develop-platform-db"
   description = "name instance"
}

variable "vm_db_platform_id" {
  type = string
  default = "standard-v1"
  description = "platform_id"
}

variable "vm_db_cores" {
  type = number
  default = 2
  description = "count cores"
}

variable "vm_db_memory" {
  type = number
  default = 2
  description = "size memory"
}

variable "vm_db_core_fraction" {
  type = number
  default = 20
  description = "fraction cpu core"
}

variable "vm_db_scheduling_policy_preemptible" {
  type = bool
  default = true
  description = "enabled preemptible"
}

variable "vm_db_network_interface_nat" {
  type = bool
  default = true
  description = "enable nat"
}

variable "vm_db_serial_port_enable" {
  type = number
  default = 1
  description = "count enable port"
}
```

### Задание 4

1. Объявите в файле outputs.tf output типа map, содержащий { instance_name = external_ip } для каждой из ВМ.
2. Примените изменения.

В качестве решения приложите вывод значений ip-адресов команды ```terraform output```.

___ 

![image](https://github.com/MaratAlaev/gitlab-hw/assets/46092593/d0e13450-bafa-4027-a17b-8ef9bcd3304d)



### Задание 5

1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию ${..} с несколькими переменными по примеру из лекции.
2. Замените переменные с именами ВМ из файла variables.tf на созданные вами local-переменные.
3. Примените изменения.

___

```terraform
locals {
    web_vm_name = "${var.vm_web_name_instance} - ${var.vm_web_platform_id}"
    db_vm_name = "${var.vm_db_name_instance} - ${var.vm_db_platform_id} "
}
```


### Задание 6

1. Вместо использования трёх переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедините их в переменные типа **map** с именами "vm_web_resources" и "vm_db_resources". В качестве продвинутой практики попробуйте создать одну map-переменную **vms_resources** и уже внутри неё конфиги обеих ВМ — вложенный map.
2. Также поступите с блоком **metadata {serial-port-enable, ssh-keys}**, эта переменная должна быть общая для всех ваших ВМ.
3. Найдите и удалите все более не используемые переменные проекта.
4. Проверьте terraform plan. Изменений быть не должно.

___

```terraform 
variable "vms" {
   type = map
   default = {
      vms_resources = {
        vm_db = {
            cores = 2,
            memory = 2,
            core_fraction = 20
        },
        vm_web = {
            cores = 2,
            memory = 1,
            core_fraction = 5
        }
      }
      vms_metadata = {
        metadata = {
            serial_port_enable = 1
            ssh_keys = "ubuntu:${"var.vms_ssh_root_key"}"
        },
      }
   }
}
```

### Задание 7*

Изучите содержимое файла console.tf. Откройте terraform console, выполните следующие задания: 

1. Напишите, какой командой можно отобразить **второй** элемент списка test_list.
2. Найдите длину списка test_list с помощью функции length(<имя переменной>).
3. Напишите, какой командой можно отобразить значение ключа admin из map test_map.
4. Напишите interpolation-выражение, результатом которого будет: "John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks", используйте данные из переменных test_list, test_map, servers и функцию length() для подстановки значений.

В качестве решения предоставьте необходимые команды и их вывод.

```
local.test_list[1]

length(local.test_list) = 3

local.test_map.admin

"${local.test_map.admin} is admin for production server based on OS ${local.servers["${local.test_list["${length(local.test_list)-1}"]}"].image} with ${local.servers["${local.test_list["${length(local.test_list)-1}"]}"].cpu} vcpu ${local.servers["${local.test_list["${length(local.test_list)-1}"]}"].ram} ram and ${local.servers["${local.test_list["${length(local.test_list)-1}"]}"].disks["${length("${local.servers["${local.test_list["${length(local.test_list)-1}"]}"].disks}")-1}"]} virtual disks"
```
