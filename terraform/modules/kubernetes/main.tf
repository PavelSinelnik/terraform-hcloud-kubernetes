# kubernetes/main.tf

locals {
  connections              = concat(var.control_plane_nodes, var.worker_nodes).*.ipv4_address
  control_plane_ip         = element(var.control_plane_nodes.*.ipv4_address, 0)
}

resource "null_resource" "install" {
  count = length(local.connections)

  connection {
    type  = "ssh"
    host  = element(local.connections, count.index)
    user  = "admin"
    agent = true
  }


  provisioner "file" {
    source      = "${path.module}/files/ccm-networks.yaml"
    destination = "/tmp/ccm-networks.yaml"
  }

  provisioner "file" {
    source      = "${path.module}/files/kube-flannel.yaml"
    destination = "/tmp/kube-flannel.yaml"
  }

  # provisioner "file" {
  #   source      = "${path.module}/files/hcloud-csi.yaml"
  #   destination = "/tmp/hcloud-csi.yaml"
  # }

  provisioner "remote-exec" {
    inline = [
      count.index < length(var.control_plane_nodes) ? data.template_file.control_plane.rendered : "echo skip"
    ]
  }
}

data "template_file" "control_plane" {
  template = file("${path.module}/scripts/control_plane.sh")

  vars = {
    kubernetes_version  = var.kubernetes_version
    floating_ip_address = var.floating_ip_address
    cluster_name        = var.cluster_name
  }
}

