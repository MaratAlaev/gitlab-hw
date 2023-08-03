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
