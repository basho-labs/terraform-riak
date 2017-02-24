variable "product_version" {
    default = "ts-1.3"
    description = "The Riak product and version. Options: ts-1.3, ts-1.2, kv-2.1.3, kv-2.0.6"
}

variable "package" {
    default = {

        kv-2.1.3-rhel6 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.1/2.1.3/rhel/6/riak-2.1.3-1.el6.x86_64.rpm"
        kv-2.1.3-rhel7 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.1/2.1.3/rhel/7/riak-2.1.3-1.el7.centos.x86_64.rpm"
        kv-2.1.3-ubuntu12 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.1/2.1.3/ubuntu/precise/riak_2.1.3-1_amd64.deb"
        kv-2.1.3-ubuntu14 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.1/2.1.3/ubuntu/trusty/riak_2.1.3-1_amd64.deb"
        kv-2.1.3-debian6 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.1/2.1.3/debian/6/riak_2.1.3-1_amd64.deb"
        kv-2.1.3-debian7 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.1/2.1.3/debian/7/riak_2.1.3-1_amd64.deb"

        kv-2.0.6-rhel6 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.0/2.0.6/rhel/6/riak-2.0.6-1.el6.x86_64.rpm"
        kv-2.0.6-rhel7 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.0/2.0.6/rhel/7/riak-2.0.6-1.el7.centos.x86_64.rpm"
        kv-2.0.6-ubuntu12 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.0/2.0.6/ubuntu/precise/riak_2.0.6-1_amd64.deb"
        kv-2.0.6-ubuntu14 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.0/2.0.6/ubuntu/trusty/riak_2.0.6-1_amd64.deb"
        kv-2.0.6-debian6 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.0/2.0.6/debian/6/riak_2.0.6-1_amd64.deb"
        kv-2.0.6-debian7 = "http://s3.amazonaws.com/downloads.basho.com/riak/2.0/2.0.6/debian/7/riak_2.0.6-1_amd64.deb"

        ts-1.2-rhel6 = "http://s3.amazonaws.com/private.downloads.basho.com/riak_ts/99a7df/1.2/1.2.0/rhel/6/riak-ts-1.2.0-1.el6.x86_64.rpm"
        ts-1.2-rhel7 = "http://s3.amazonaws.com/private.downloads.basho.com/riak_ts/99a7df/1.2/1.2.0/rhel/7/riak-ts-1.2.0-1.el7.centos.x86_64.rpm"
        ts-1.2-ubuntu12 = "http://s3.amazonaws.com/private.downloads.basho.com/riak_ts/99a7df/1.2/1.2.0/ubuntu/precise/riak-ts_1.2.0-1_amd64.deb"
        ts-1.2-ubuntu14 = "http://s3.amazonaws.com/private.downloads.basho.com/riak_ts/99a7df/1.2/1.2.0/ubuntu/trusty/riak-ts_1.2.0-1_amd64.deb"
        ts-1.2-debian7 = "http://s3.amazonaws.com/private.downloads.basho.com/riak_ts/99a7df/1.2/1.2.0/debian/7/riak-ts_1.2.0-1_amd64.deb"

	ts-1.3-rhel6 = "https://s3.amazonaws.com/downloads.basho.com/riak_ts/1.3/1.3.0/rhel/6/riak-ts-1.3.0-1.el6.x86_64.rpm"
	ts-1.3-rhel7 = "https://s3.amazonaws.com/downloads.basho.com/riak_ts/1.3/1.3.0/rhel/7/riak-ts-1.3.0-1.el7.x86_64.rpm"
	ts-1.3-ubuntu12 = "https://s3.amazonaws.com/downloads.basho.com/riak_ts/1.3/1.3.0/ubuntu/precise/riak-ts_1.3.0-1_amd64.deb"
	ts-1.3-ubuntu14 = "https://s3.amazonaws.com/downloads.basho.com/riak_ts/1.3/1.3.0/ubuntu/trusty/riak-ts_1.3.0-1_amd64.deb"
	ts-1.3-debian7 = "https://s3.amazonaws.com/downloads.basho.com/riak_ts/1.3/1.3.0/debian/7/riak-ts_1.3.0-1_amd64.deb"

        ts-1.5.1-ubuntu14 = "https://s3.amazonaws.com/downloads.basho.com/riak_ts/1.5/1.5.1/ubuntu/trusty/riak-ts_1.5.1-1_amd64.deb"


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
    default = "default"
    description = "AWS security group name"
}
