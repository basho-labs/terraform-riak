variable "instance_type" {
    default = "t2.medium"
    description = "AWS Instance type, if you change, make sure it is compatible with AMI, not all AMIs allow all instance types "
}

variable "security_group_name" {
    default = "default"
    description = "AWS security group name"
}

variable "tagName" {
    default = "riak-clients"
    description = "Name tag for the servers"
}

variable "count" {
    default = "1"
    description = "The number of instances to launch."
}
