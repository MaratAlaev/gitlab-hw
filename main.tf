terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"

 backend "s3" {
  endpoint = "storage.yandexcloud.net"
  bucket = "my-tfstate-1"
  key = "terraform.tfstate"
  region = "ru-central1"
 
  skip_region_validation = true
  skip_credentials_validation = true

  dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1g5uqdv6c1ofocq53vq/etn9tvhn38m8rcsh7h8j"
  dynamodb_table = "table"
}


 # backend "s3" {
 # endpoint = "storage.yandexcloud.net"
 # bucket = "my-tfstate-1"
 # key = "terraform.tfstate"
 # region = "ru-central1"
 #
 # skip_region_validation = true
 # skip_credentials_validation = true
 #}

}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}



#создаем облачную сеть
#resource "yandex_vpc_network" "develop" {
#  name = "develop"
#}

#создаем подсеть
#resource "yandex_vpc_subnet" "develop" {
#  name           = "develop-ru-central1-a"
#  zone           = "ru-central1-a"
#  network_id     = yandex_vpc_network.develop.id
#  v4_cidr_blocks = ["10.0.1.0/24"]
#}

module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone         = "ru-central1-a"
  cidr         = ["10.0.1.0/24"]
}

module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = module.vpc_dev.network_id
  subnet_zones    = [module.vpc_dev.subnet_zone]
  subnet_ids      = [module.vpc_dev.subnet_id]
  instance_name   = "web"
  instance_count  = 2
  image_family    = "ubuntu-2004-lts"
  public_ip       = true
  
  metadata = {
      user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
      serial-port-enable = 1
  }

}

#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
 template = file("./cloud-init.yml")

 vars = {
  ssh_public_key = file("~/.ssh/id_rsa.pub") 
 }
}

