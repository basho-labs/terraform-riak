output "public_ip_1" {
    value = "${aws_instance.primary.public_ip}"
}

output "public_ip_2_to_n-1" {
    value = "${join(",", aws_instance.secondary.*.public_ip)}"
}

output "public_ip_n" {
    value = "${aws_instance.final.public_ip}"
}
