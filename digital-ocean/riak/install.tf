resource "digitalocean_droplet" "primary" {

    image = "${lookup(var.image, concat(var.region, "-", var.platform))}"
    size = "${var.size}"
    region = "${var.region}"
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]
    private_networking = true
    connection {
        user = "${lookup(var.user, var.platform)}"
        type = "ssh"
        key_file = "${var.pvt_key}"
        timeout = "2m"
    }

    name = "riak-${var.product_version}-${var.platform}-0"

    provisioner "remote-exec" {
        inline = [
	    "echo ${lookup(var.package, concat(var.product_version, "-", var.platform))} > /tmp/package",
        ]
    }

    provisioner "remote-exec" {
        inline = [
            "echo 'DIGITAL_OCEAN' > /tmp/provider",
        ]
    }

    provisioner "remote-exec" {
        scripts = [
            "${path.module}/../../scripts/terraform/riak/bootstrap-${lookup(var.platform_base, var.platform)}.sh",
        ]
    }

}

resource "digitalocean_droplet" "secondary" {
    
    image = "${lookup(var.image, concat(var.region, "-", var.platform))}"
    size = "${var.size}"
    region = "${var.region}"
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]
    private_networking = true
    connection {
        user = "${lookup(var.user, var.platform)}"
        type = "ssh"
        key_file = "${var.pvt_key}"
        timeout = "2m"
    }

    count = "${var.nodes - 2}"
    name = "riak-${var.product_version}-${var.platform}-${count.index + 1}"

    depends_on = ["digitalocean_droplet.primary"]

    provisioner "remote-exec" {
        inline = [
            "echo ${digitalocean_droplet.primary.ipv4_address_private} > /tmp/primary_ip",
            "echo ${lookup(var.package, concat(var.product_version, "-", var.platform))} > /tmp/package",
        ]
    }

    provisioner "remote-exec" {
        inline = [
            "echo 'DIGITAL_OCEAN' > /tmp/provider",
        ]
    }

    provisioner "remote-exec" {
        scripts = [
            "${path.module}/../../scripts/terraform/riak/bootstrap-${lookup(var.platform_base, var.platform)}.sh",
	    "${path.module}/../../scripts/terraform/riak/join.sh",
        ]
    }

}

resource "digitalocean_droplet" "final" {

    image = "${lookup(var.image, concat(var.region, "-", var.platform))}"
    size = "${var.size}"
    region = "${var.region}"
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]
    private_networking = true
    connection {
        user = "${lookup(var.user, var.platform)}"
        type = "ssh"
        key_file = "${var.pvt_key}"
        timeout = "2m"
    }

    name = "riak-${var.product_version}-${var.platform}-${var.nodes - 1}"

    depends_on = ["digitalocean_droplet.secondary"]

    provisioner "remote-exec" {
        inline = [
            "echo ${digitalocean_droplet.primary.ipv4_address_private} > /tmp/primary_ip",
            "echo ${lookup(var.package, concat(var.product_version, "-", var.platform))} > /tmp/package",
        ]
    }

    provisioner "remote-exec" {
        inline = [
            "echo 'DIGITAL_OCEAN' > /tmp/provider",
        ]
    }

    provisioner "remote-exec" {
        scripts = [
            "${path.module}/../../scripts/terraform/riak/bootstrap-${lookup(var.platform_base, var.platform)}.sh",
	    "${path.module}/../../scripts/terraform/riak/join.sh",
	    "${path.module}/../../scripts/terraform/riak/cluster.sh",
        ]
    }

}
