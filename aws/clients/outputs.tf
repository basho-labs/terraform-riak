output "server_address" {
    value = "${aws_instance.server.public_ip}"
}
