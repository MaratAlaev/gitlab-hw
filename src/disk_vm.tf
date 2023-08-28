resource "yandex_compute_disk" "disk" {
  count = 3
  name  = "disk-${count.index}"
  size  = 1
  zone  = var.default_zone
}

resource "yandex_compute_instance" "storage" {
  name = "storage"
  platform_id = var.vm_web_platform_id
  
  resources {
    cores = var.vms.vms_resources.vm.cores
    memory = var.vms.vms_resources.vm.memory
    core_fraction = var.vms.vms_resources.vm.core_fraction
  }

  boot_disk {
   initialize_params {
    image_id = data.yandex_compute_image.ubuntu.image_id
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