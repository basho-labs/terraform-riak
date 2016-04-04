variable "size" {
    default = "512mb"
    description = "Digital Ocean droplet size."
}

variable "tagName" {
    default = "riak-clients"
    description = "Name tag for the servers"
}

variable "count" {
    default = "1"
    description = "The number of instances to launch."
}
