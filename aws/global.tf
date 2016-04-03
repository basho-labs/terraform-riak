provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.region}"
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
	rhel6 = "ec2-user"
        rhel7 = "ec2-user"
	ubuntu12 = "ubuntu"
	ubuntu14 = "ubuntu"
	debian6 = "admin"
	debian7 = "admin"
    }
}

variable "ami" {
    description = "AWS AMI Id, if you change, make sure it is compatible with instance type, not all AMIs allow all instance types "
    default = {
        us-east-1-rhel6 = "ami-00a11e68"
        us-east-1-rhel7 = "ami-2051294a"
        us-east-1-ubuntu12 = "ami-0611546c"
	us-east-1-ubuntu14 = "ami-d05e75b8"
	us-east-1-debian6 = "ami-5e12dc36"
	us-east-1-debian7 = "ami-e0efab88"
    }
}

variable "key_name" {
    default = ""
    description = "SSH key name in your AWS account for AWS instances."
}

variable "key_path" {
    default = ""
    description = "Path to the private key specified by key_name."
}

variable "aws_access_key" {
    default = ""
    description = "AWS access key."
}

variable "aws_secret_key" {
    default = ""
    description = "AWS secret key."
}

variable "region" {
    default = "us-east-1"
    description = "The region of AWS, for AMI lookups."
}
