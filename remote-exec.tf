# TODO: Push API keys to bastion VM.

resource "null_resource" "remote-exec" {
    depends_on = ["baremetal_core_instance.bosh_cli"]
    provisioner "remote-exec" {
      connection {
        agent = false
        timeout = "10m"
        host = "${data.baremetal_core_vnic.InstanceVnic.public_ip_address}"
        user = "${var.bosh_ssh_username}"
        private_key = "${file(var.bosh_ssh_private_key)}"
      }
      inline = [
        "sudo curl -o /usr/local/bin/bosh https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-2.0.16-linux-amd64",
        "sudo chmod +x /usr/local/bin/bosh",
      ]
    }
}

