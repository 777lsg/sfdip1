variable "zone_a" {
  description = "Use specific availability zone"
  type        = string
  default     = "ru-central1-a"
}



terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
}


provider "yandex" {
  service_account_key_file = file("~/terraformv1/yandex-cloud/key.json")
  cloud_id                 = "b1gl19hep4vav8g6vuif"
  folder_id                = "b1gsb8ra83s7khsdi62m"
  zone                     = var.zone_a
}

resource "yandex_vpc_network" "network" {
  name = "network"
}


resource "yandex_vpc_subnet" "subnet1" {
  name           = "subnet1"
  zone           = var.zone_a
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}


data "yandex_compute_image" "ubuntu-2204-lts" {
  family = "ubuntu-2204-lts"
}


resource "yandex_compute_instance" "vm-1" {
  name = "master"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2204-lts.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}


resource "yandex_compute_instance" "vm-2" {
  name = "app"
  zone = var.zone_a

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2204-lts.id
    }

  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}



resource "yandex_compute_instance" "vm-3" {
  name = "srv"
  zone = var.zone_a

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2204-lts.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}



resource "yandex_lb_target_group" "group_web_1" {
  name      = "my-target-group"
  region_id = "ru-central1"

  target {
    subnet_id = yandex_vpc_subnet.subnet1.id
    address   = yandex_compute_instance.vm-1.network_interface.0.ip_address
  }

}


resource "yandex_lb_network_load_balancer" "web_lb_1" {
  name = "my-network-load-balancer"

  listener {
    name        = "my-listener"
    port        = 80
    target_port = 31060
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.group_web_1.id

    healthcheck {
      name = "http"
      http_options {
        port = 31060
        path = "/"
      }
    }
  }
}




output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}


output "external_ip_address_vm_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
}


output "external_ip_address_vm_3" {
  value = yandex_compute_instance.vm-3.network_interface.0.nat_ip_address
}


output "external_ip_address_lb" {
  value = yandex_lb_network_load_balancer.web_lb_1.listener.*.external_address_spec[0].*.address
}

