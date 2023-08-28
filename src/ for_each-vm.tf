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

resource "yandex_compute_instance" "for" {
  depends_on =[resource.yandex_compute_instance.count] 
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
    image_id = data.yandex_compute_image.ubuntu.image_id
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