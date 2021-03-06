terraform {
  required_providers {
    docker = {

      source  = "kreuzwerker/docker"
      version = "~> 2.15"

    }
  }
}

provider "docker" {}

resource "null_resource" "dockervol" {
  provisioner "local-exec" {
    command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol"
  }
}


resource "docker_image" "nodered_image" {
  name = var.image[terraform.workspace]
}

resource "random_string" "random" {
  count   = local.conatiner_count
  length  = 4
  special = false
  upper   = false
}


resource "docker_container" "nodered_container" {
  count = local.conatiner_count
  name  = join("-", ["nodered", terraform.workspace, random_string.random[count.index].result])
  image = docker_image.nodered_image.latest

  ports {
    internal = 1300
    external = var.ext_port[terraform.workspace][count.index]

  }

  volumes {
    container_path = "/data"
    host_path      = "/home/ubuntu/environment/terraform-docker/noderedvol"
  }
}





