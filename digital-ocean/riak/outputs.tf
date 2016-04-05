output "public_ip_1" {
    value = "${digitalocean_droplet.primary.ipv4_address}"
}

output "public_ip_2_to_n-1" {
    value = "${join(",", digitalocean_droplet.secondary.*.ipv4_address)}"
}

output "public_ip_n" {
    value = "${digitalocean_droplet.final.ipv4_address}"
}

output "private_ip_1" {
    value = "${digitalocean_droplet.primary.ipv4_address_private}"
}

output "private_ip_2_to_n-1" {
    value = "${join(",", digitalocean_droplet.secondary.*.ipv4_address_private)}"
}

output "private_ip_n" {
    value = "${digitalocean_droplet.final.ipv4_address_private}"
}
