locals {
  instances = {
    "terraform1" = "epda9gsnpd8gkk2i3pir",
    "terraform2" = "epdg1ipoge0on9ij243e"
  }
}

resource "yandex_compute_instance" "vm" {
  for_each = local.instances

  name = each.key

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = each.value
      size     = 15
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.admin_ssh_key}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm["terraform1"].network_interface.0.ip_address
}

output "internal_ip_address_vm_2" {
  value = yandex_compute_instance.vm["terraform2"].network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm["terraform1"].network_interface.0.nat_ip_address
}

output "external_ip_address_vm_2" {
  value = yandex_compute_instance.vm["terraform2"].network_interface.0.nat_ip_address
}

resource "datadog_monitor" "healthcheck" {
  name    = "Healthcheck monitor"
  type    = "service check"
  query   = "\"http.can_connect\".over(\"instance:datadog_health_check\").by(\"host\",\"instance\",\"url\").last(4).count_by_status()"
  message = "{{host.name}} not available"
}