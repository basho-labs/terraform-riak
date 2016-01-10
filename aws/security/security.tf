resource "aws_security_group" "riakts-test" {
    name = "${var.name}"
    description = "Riak security group"

    // Open all ingress ports to internal traffic
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        self = true
    }

    // Ping
    ingress {
        from_port = 8
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    // SSH
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    // PB
    ingress {
        from_port = 8087
        to_port = 8087
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    // HTTP
    ingress {
        from_port = 8098
        to_port = 8098
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    // Outbound
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

