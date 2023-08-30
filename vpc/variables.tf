variable "zone" {
  type        = string
  default     = "ru-central1-a"
   validation {
     condition = contains(["ru-central1-a", "ru-central1-b", "ru-central1-c"], var.zone)
     error_message = "Invalid zone."
   }
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "env_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}