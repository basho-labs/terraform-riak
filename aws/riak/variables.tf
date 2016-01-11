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

        ts-1.0-rhel6 = "http://s3.amazonaws.com/private.downloads.basho.com/riak_ts/a7b9fc/1.0.0/rhel/6/riak-ts-1.0.0-1.el6.x86_64.rpm"
        ts-1.0-rhel7 = "http://s3.amazonaws.com/private.downloads.basho.com/riak_ts/a7b9fc/1.0.0/rhel/7/riak-ts-1.0.0-1.el7.centos.x86_64.rpm"
        ts-1.0-ubuntu12 = "http://s3.amazonaws.com/private.downloads.basho.com/riak_ts/a7b9fc/1.0.0/ubuntu/precise/riak-ts_1.0.0-1_amd64.deb"
        ts-1.0-ubuntu14 = "http://s3.amazonaws.com/private.downloads.basho.com/riak_ts/a7b9fc/1.0.0/ubuntu/trusty/riak-ts_1.0.0-1_amd64.deb"
        ts-1.0-debian6 = "http://s3.amazonaws.com/private.downloads.basho.com/riak_ts/a7b9fc/1.0.0/debian/6/riak-ts_1.0.0-1_amd64.deb"
        ts-1.0-debian7 = "http://s3.amazonaws.com/private.downloads.basho.com/riak_ts/a7b9fc/1.0.0/debian/7/riak-ts_1.0.0-1_amd64.deb"

    }
    description = "Per product/version/platform package paths."
}

variable "nodes" {
    default = "3"
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

variable "tagName" {
    default = "riakts"
    description = "Name tag for the servers"
}
