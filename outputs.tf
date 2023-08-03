output "ip" {
    value = {"${yandex_compute_instance.web.name}" = "${yandex_compute_instance.web.network_interface.0.ip_address}", 
         "${yandex_compute_instance.db.name}"=  "${yandex_compute_instance.db.network_interface.0.ip_address}"
}
}