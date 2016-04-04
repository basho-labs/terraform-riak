provider "digitalocean" {
    token = "${var.token}"
}

variable "platform" {
    default = "ubuntu14"
    description = "The OS Platform. Supported platforms are rhel6, rhel7, ubuntu12, ubuntu14, debian6, debian7."
}

variable "platform_base" {
    default = {
        rhel6 = "rhel"
	rhel7 = "rhel"
	ubuntu12 = "debian"
	ubuntu14 = "debian"
	debian6 = "debian"
	debian7 = "debian"
    }
}

variable "user" {
    default = {
	rhel6 = "root"
        rhel7 = "root"
	ubuntu12 = "root"
	ubuntu14 = "root"
	debian6 = "root"
	debian7 = "root"
    
}

variable "image" {
    description = "Digital Ocean image ID."
    default = {
        sfo1-rhel6 = "centos-6-5-x64"
        sfo1-rhel7 = "centos-7-0-x64"
        sfo1-ubuntu12 = "ubuntu-12-04-x64"
	sfo1-ubuntu14 = "ubuntu-14-04-x64"
	sfo1-debian7 = "debian-7-0-x64"
    }
}

variable "token" {
    default = "36e740c26e5d835c8df880c254d3aadf12341197673860845071ba872961e17e"
    description = "Digital Ocean API token."
}

variable "pub_key" {
    default = "/home/vagrant/.ssh/basho-do.pub"
    description = "Path to the public key."
}

variable "pvt_key" {
    default = "/home/vagrant/.ssh/basho-do"
    description = "Path to the private key."
}

variable "ssh_fingerprint" {
    default = "f5:2d:4a:54:c1:8f:71:ec:13:75:55:12:c6:8e:fb:0f"
    description = "SSH key fingerprint."
}

variable "region" {
    default = "sfo1"
    description = "The Digital Ocean region."
}
