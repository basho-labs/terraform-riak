output "public_IPs" {
    value = "${join(",", digitalocean_droplet.server.*.ipv4_address)}"
}

output "private_IPs" {
    value = "${join(",", digitalocean_droplet.server.*.ipv4_address_private)}"
}
