resource "aws_instance" "server" {
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
        Name = "${var.tagName}-${var.platform}"
    }

    provisioner "remote-exec" {
        scripts = [
            "${path.module}/bootstrap-${lookup(var.platform-base, var.platform)}.sh",
        ]
    }

    # Copy Python files
    provisioner "file" {
        source = "${path.module}/python/TSInsert.py"
        destination = "/home/${lookup(var.user, var.platform)}/scripts/python/TSInsert.py"
    }

    provisioner "file" {
        source = "${path.module}/python/TSQuery.py"
        destination = "/home/${lookup(var.user, var.platform)}/scripts/python/TSQuery.py"
    }

    # Copy Java files
    provisioner "file" {
        source = "${path.module}/java/TSInsert.java"
        destination = "/home/${lookup(var.user, var.platform)}/scripts/java/TSInsert.java"
    }

    provisioner "file" {
        source = "${path.module}/java/TSQuery.java"
        destination = "/home/${lookup(var.user, var.platform)}/scripts/java/TSQuery.java"
    }

    # Copy Erlang files
    provisioner "file" {
        source = "${path.module}/erlang/TSInsert"
        destination = "/home/${lookup(var.user, var.platform)}/scripts/erlang/TSInsert"
    }

    provisioner "file" {
        source = "${path.module}/erlang/TSQuery"
        destination = "/home/${lookup(var.user, var.platform)}/scripts/erlang/TSQuery"
    }

    provisioner "remote-exec" {
        scripts = [
            "${path.module}/compile.sh",
        ]
    }

}
