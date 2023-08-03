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
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFv7rokkI3hZEhBI1IqeN4Pcr91ZQi0bQigkr4Y7GnDq3PBKMlKpijvDG5UOBS9OPbBP+s58Ojf0KwXxQ6Bb9Nhwz3n8S75gRcQGF2oYU8Ka4FGxZsZNBivMvMLhSCQXTJz9fvdHlucWyCMkTwioTHIZnszTd1mWuh4rCBzZ2VmRs2DDa3L/31vuMeC5LZLKAgVn3EQTm+wy3kWrpnQKEbQlkSEzOXcMSfKI30s1a2xMZQ84qK2fS4kzJkXDgqcoLq8ozjtC0JNfclv9RjAGRM5Oz0jZ41Yh7doFVB+jCkCY2c6b5YrZJl3a0aogvKRjtdsr9tQNfnBQq1NXlsO2ri3wc6Un1YQAqw0SrmH/J/Z48nHDp0yC+cMm5aBx30tq70tMMnMtTn+8mbOq1nIilZw0gVtcMO4SVSkrCABaIEAZ5bOJ27ZYqXZ8iSrpMu3/VA9amrUsMhU7gat/iKj0MeJcQHcRcICiqvdDNosLzEQ8wracLQ6nBS6imcSNCHEhc= marat@ubuntu"
  description = "ssh-keygen -t ed25519"
}

