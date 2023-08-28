output "vm" {
    value = tomap({
      for k, inst in yandex_compute_instance: k => inst.id
  })
}