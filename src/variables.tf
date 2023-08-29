###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

###vm

variable "vm_web_platform_id" {
  type = string
  default = "standard-v1"
  description = "platform_id"
}

variable "vm_web_image_name" {
  type = string
  default = "ubuntu-2004-lts"
  description = "name image"
}

variable "vms" {
   type = map
   default = {
      vms_resources = {
        vm = {
            cores = 2,
            memory = 2,
            core_fraction = 5
        }
      }
   }
}
