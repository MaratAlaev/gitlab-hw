output "network_name" {
  value = yandex_vpc_network.develop.name
}

output "subnet_zone" {
  value = yandex_vpc_subnet.develop.zone
}

output "cidr" {
  value = yandex_vpc_subnet.develop.v4_cidr_blocks
}

output "network_id" {
  value = yandex_vpc_network.develop.id
}

output "subnet_id" {
  value = yandex_vpc_subnet.develop.id
}