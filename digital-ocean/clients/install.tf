resource "digitalocean_droplet" "server" {
    image = "${lookup(var.image, concat(var.region, "-", var.platform))}"
    size = "${var.size}"
    count = "${var.count}"
    region = "${var.region}"
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]
    private_networking = true
    connection {
        user = "${lookup(var.user, var.platform)}"
        type = "ssh"
        key_file = "${var.key_path}"
        timeout = "2m"
    }

    name = "${var.tagName}-${var.platform}-${count.index}"

    provisioner "remote-exec" {
        scripts = [
            "${path.module}/../../scripts/terraform/clients/bootstrap-${lookup(var.platform_base, var.platform)}.sh",
        ]
    }

    provisioner "file" {
	source = "${path.module}/examples/"
	destination = "/${lookup(var.user, var.platform)}/examples"
    }    

}
