output "server_address" {
    value = "${join(",", digitalocean_droplet.server.*.public_ip)}"
}
