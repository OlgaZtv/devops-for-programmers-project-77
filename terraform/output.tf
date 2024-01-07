output "inventory" {
  value = templatefile(
    "inventory.tpl",
    {
      webserver1 = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address,
      webserver2 = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
    }
  )
}