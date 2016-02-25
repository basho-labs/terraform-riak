resource "aws_instance" "primary" {
    ami = "${lookup(var.ami, concat(var.region, "-", var.platform))}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_name}"
    security_groups = ["${var.security_group_name}"]
    connection {
        user = "${lookup(var.user, var.platform)}"
        key_file = "${var.key_path}"
    }

    #Instance tags
    tags {
        Name = "riak-${var.product-version}-${var.platform}-0"
    }

    # Generate a shared SSH key for the cluster
    provisioner "local-exec" {
        command = "rm -f id_rsa id_rsa.pub; ssh-keygen -P '' -f id_rsa"
    }
    provisioner "file" {
        source = "id_rsa"
        destination = "/home/${lookup(var.user, var.platform)}/.ssh/id_rsa"
    }
    provisioner "file" {
        source = "id_rsa.pub"
        destination = "/home/${lookup(var.user, var.platform)}/.ssh/id_rsa.pub"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod 600 /home/${lookup(var.user, var.platform)}/.ssh/id_rsa",
            "echo ${lookup(var.package, concat(var.product-version, "-", var.platform))} > /tmp/package",
        ]
    }

    provisioner "remote-exec" {
        scripts = [
            "${path.module}/bootstrap-${lookup(var.platform-base, var.platform)}.sh",
        ]
    }

    # Copy scripts
    provisioner "file" {
        source = "${path.module}/create_ts_bucket.sh"
        destination = "/home/${lookup(var.user, var.platform)}/scripts/create_ts_bucket.sh"
    }
}

resource "aws_instance" "secondary" {
    ami = "${lookup(var.ami, concat(var.region, "-", var.platform))}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_name}"
    count = "${var.nodes - 2}"
    security_groups = ["${var.security_group_name}"]

    connection {
        user = "${lookup(var.user, var.platform)}"
        key_file = "${var.key_path}"
    }

    #Instance tags
    tags {
        Name = "riak-${var.product-version}-${var.platform}-${count.index + 1}"
    }

    depends_on = ["aws_instance.primary"]

    provisioner "file" {
        source = "id_rsa"
        destination = "/home/${lookup(var.user, var.platform)}/.ssh/id_rsa"
    }
    provisioner "file" {
        source = "id_rsa.pub"
        destination = "/home/${lookup(var.user, var.platform)}/.ssh/id_rsa.pub"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod 600 /home/${lookup(var.user, var.platform)}/.ssh/id_rsa",
            "echo ${aws_instance.primary.private_ip} > /tmp/primary_ip",
            "echo ${lookup(var.package, concat(var.product-version, "-", var.platform))} > /tmp/package",
        ]
    }

    provisioner "remote-exec" {
        scripts = [
            "${path.module}/bootstrap-${lookup(var.platform-base, var.platform)}.sh",
	    "${path.module}/join.sh",
        ]
    }

    # Copy scripts
    provisioner "file" {
        source = "${path.module}/create_ts_bucket.sh"
        destination = "/home/${lookup(var.user, var.platform)}/scripts/create_ts_bucket.sh"
    }
}

resource "aws_instance" "final" {
    ami = "${lookup(var.ami, concat(var.region, "-", var.platform))}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_name}"
    security_groups = ["${var.security_group_name}"]
    connection {
        user = "${lookup(var.user, var.platform)}"
        key_file = "${var.key_path}"
    }

    #Instance tags
    tags {
	Name = "riak-${var.product-version}-${var.platform}-${var.nodes - 1}"
    }

    depends_on = ["aws_instance.secondary"]

    provisioner "file" {
        source = "id_rsa"
        destination = "/home/${lookup(var.user, var.platform)}/.ssh/id_rsa"
    }
    provisioner "file" {
        source = "id_rsa.pub"
        destination = "/home/${lookup(var.user, var.platform)}/.ssh/id_rsa.pub"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod 600 /home/${lookup(var.user, var.platform)}/.ssh/id_rsa",
            "echo ${aws_instance.primary.private_ip} > /tmp/primary_ip",
            "echo ${lookup(var.package, concat(var.product-version, "-", var.platform))} > /tmp/package",
            "echo ${concat(format("^riak@%s^",aws_instance.primary.private_ip),",",join(",",formatlist("^riak@%s^",aws_instance.secondary.*.private_ip)),",",format("^riak@%s^",self.private_ip))} > /tmp/cluster",
        ]
    }

    provisioner "remote-exec" {
        scripts = [
            "${path.module}/bootstrap-${lookup(var.platform-base, var.platform)}.sh",
	    "${path.module}/join.sh",
	    "${path.module}/cluster.sh",
        ]
    }

    # Copy scripts
    provisioner "file" {
        source = "${path.module}/create_ts_bucket.sh"
        destination = "/home/${lookup(var.user, var.platform)}/scripts/create_ts_bucket.sh"
    }

}
