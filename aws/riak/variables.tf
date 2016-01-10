variable "package" {
    default = {
	rhel6 = "http://s3.amazonaws.com/private.downloads.basho.com/riak_ts/a7b9fc/1.0.0/rhel/6/riak-ts-1.0.0-1.el6.x86_64.rpm"
	rhel7 = "http://s3.amazonaws.com/private.downloads.basho.com/riak_ts/a7b9fc/1.0.0/rhel/7/riak-ts-1.0.0-1.el7.centos.x86_64.rpm"
	ubuntu14 = "http://s3.amazonaws.com/private.downloads.basho.com/riak_ts/a7b9fc/1.0.0/ubuntu/trusty/riak-ts_1.0.0-1_amd64.deb"
	ubuntu12 = "http://s3.amazonaws.com/private.downloads.basho.com/riak_ts/a7b9fc/1.0.0/ubuntu/precise/riak-ts_1.0.0-1_amd64.deb"
	debian6 = "http://s3.amazonaws.com/private.downloads.basho.com/riak_ts/a7b9fc/1.0.0/debian/6/riak-ts_1.0.0-1_amd64.deb"
	debian7 = "http://s3.amazonaws.com/private.downloads.basho.com/riak_ts/a7b9fc/1.0.0/debian/7/riak-ts_1.0.0-1_amd64.deb"
    }
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
