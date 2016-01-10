output "primary_public_ip" {
    value = "${aws_instance.primary.public_ip}"
}

output "secondary_public_ips" {
    value = "${join(",", aws_instance.secondary.*.public_ip)}"
}

output "final_public_ip" {
    value = "${aws_instance.final.public_ip}"
}
