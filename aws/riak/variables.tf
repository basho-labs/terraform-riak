variable "product-version" {
    default = "kv-2.0.6"
    description = "The Riak product and version. e.g., ts-1.0, kv-2.0.6"
}

variable "package" {
    default = {
        kv-2.0.6-rhel6 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.0/2.0.6/rhel/6/riak-2.0.6-1.el6.x86_64.rpm"
        kv-2.0.6-rhel7 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.0/2.0.6/rhel/7/riak-2.0.6-1.el7.centos.x86_64.rpm"
        kv-2.0.6-ubuntu12 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.0/2.0.6/ubuntu/precise/riak_2.0.6-1_amd64.deb"
        kv-2.0.6-ubuntu14 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.0/2.0.6/ubuntu/trusty/riak_2.0.6-1_amd64.deb"
        kv-2.0.6-debian6 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.0/2.0.6/debian/6/riak_2.0.6-1_amd64.deb"
        kv-2.0.6-debian7 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.0/2.0.6/debian/7/riak_2.0.6-1_amd64.deb"

        ts-1.0-rhel6 = ""
        ts-1.0-rhel7 = ""
        ts-1.0-ubuntu12 = ""
        ts-1.0-ubuntu14 = ""
        ts-1.0-debian6 = ""
        ts-1.0-debian7 = ""

        ts-1.1-rhel6 = ""
        ts-1.1-rhel7 = ""
        ts-1.1-ubuntu12 = ""
        ts-1.1-ubuntu14 = ""
        ts-1.1-debian6 = ""
        ts-1.1-debian7 = ""

    }
    description = "Per product/version/platform package paths."
}

variable "nodes" {
    default = "5"
    description = "The number of Riak nodes to launch."
}

variable "instance_type" {
    default = "t2.medium"
    description = "AWS Instance type, if you change, make sure it is compatible with AMI, not all AMIs allow all instance types "
}

variable "security_group_name" {
    default = "riak"
    description = "AWS security group name"
}
