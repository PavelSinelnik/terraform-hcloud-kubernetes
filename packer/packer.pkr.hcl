variable "token" {
  type      = string
  default   = "${env("HCLOUD_TOKEN")}"
  sensitive = true
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "hcloud" "kub" {
  image       = "ubuntu-22.04"
  location    = "fsn1"
  server_name = "kub-worker"
  server_type = "cx11"
  snapshot_labels = {
    engine = "kub"
    infra  = "kub"
  }
  snapshot_name = "kub-${local.timestamp}"
  ssh_username  = "root"
  token         = "${var.token}"
}

build {
  sources = ["source.hcloud.kub"]

  provisioner "shell" {
    inline = ["sudo apt update", "sudo apt install ansible -y"]
  }


  provisioner "ansible-local" {
    extra_arguments   = ["--extra-vars \"worker_name=worker kube_version=1.22.5-00 node_type=cpu\" -u user"]
    playbook_dir      = "../ansible"
    playbook_file     = "../ansible/prepare_host.yml"
    staging_directory = "/root/ansible"
  }

}