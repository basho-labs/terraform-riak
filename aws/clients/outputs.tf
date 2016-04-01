output "server_address" {
    value = "${join(",", aws_instance.server.*.public_ip)}"
}
