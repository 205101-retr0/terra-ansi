resource "docker_image" "sshnx" {
    name="tejaind30/ssh-nxserver:v2.2"
}

resource "docker_image" "sshans" {
    name="tejaind30/ssh-aeserver:v3.4"
}

variable "num" { }

resource "docker_container" "slaves" {
    name="Ansible-slave-0${count.index + 1}"
    count=var.num
    image=docker_image.sshnx.image_id
    rm=true

    ports {
        internal = "80"
        external = "808${count.index}"
    }

    ports{
        internal = "22"
        external = "222${count.index}"
    }

    networks_advanced {
        name = "${docker_network.cont_network.name}"
    }
}

resource "docker_container" "master" {
    name="Ansible-master"
    image=docker_image.sshans.image_id
    rm=true

    ports{
        internal = "22"
        external = "2277" # Cause ord(M) -> 77
    }

    networks_advanced {
        name = "${docker_network.cont_network.name}"
    }
}

resource "docker_network" "cont_network" {
    name = "priv_net"
    driver = "bridge"

    ipam_config {
        subnet = "10.10.0.0/24"
        gateway = "10.10.0.1"
    }
}