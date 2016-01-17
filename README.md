# terraform-riak

terraform-riak is a tool that allows you to provision Riak KV and TS clusters on EC2 with a single command. It also enables you to provision a separate instance pre-configured with the Python, Java and Erlang clients. Remote command execution with Ansible is supported as well.

## Setup

(This [gist](https://gist.github.com/rcgenova/589102cf4ed66e0178c9) has a concise set of commands that will get you up and running quickly in a Vagrant environment.)

* [Install Terraform](https://terraform.io/intro/getting-started/install.html)
* [Install Ansible](http://docs.ansible.com/ansible/intro_installation.html)
* Clone this repo

```bash
$ git clone https://github.com/basho-labs/terraform-riak.git
```

The path to `terraform-riak` is referred to as `[TR-HOME]` below.

* Configure AWS access

  * Access keys: [http://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html](http://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html)

  * Key pair: [http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)

  * Update the `key_name`, `key_path`, `aws_access_key` and `aws_secret_key` variables in aws/global.tf

## Usage

Create a `working` subdirectory:

```bash
$ mkdir [TR-HOME]/working
```

### AWS Security group

The Riak cluster terraform configuration expects the AWS security group 'riak' to be present. The following commands will create it:

```bash
$ mkdir [TR-HOME]/working/security
$ cd [TR-HOME]/working/security
$ terraform apply ../../aws/security
```

### Provision Riak

The `terraform apply` command takes the following variables:

* `product_version` (default: kv-2.1.3; options: kv-2.1.3, kv-2.0.6, ts-1.1, ts-1.0)
* `platform` (default: rhel6; options: rhel6, rhel7, ubuntu12, ubuntu14, debian6, debian7)
* `nodes` (default: 5; options: must be >= 3)
* `instance_type` (default: t2.medium; options: any AWS instance type)

The following will provision a Riak KV 2.1.3 cluster using the RHEL 6 package:

```bash
$ mkdir [TR-HOME]/working/kv-2.1.3-rhel6
$ cd [TR-HOME]/working/kv-2.1.3-rhel6
$ terraform apply -var 'product_version=kv-2.1.3' -var 'platform=rhel6' ../../aws/riak
```

The provision a Riak KV 2.0.6 cluster using the Ubuntu14 package:

```bash
$ mkdir [TR-HOME]/working/kv-2.0.6-rhel6
$ cd [TR-HOME]/working/kv-2.0.6-rhel6
$ terraform apply -var 'product_version=kv-2.0.6' -var 'platform=ubuntu14' ../../aws/riak
```

To provision a Riak TS 1.1 cluster using the Debian 7 package:

```bash
$ mkdir [TR-HOME]/working/ts-1.1-debian7
$ cd [TR-HOME]/working/ts-1.1-debian7
$ terraform apply -var 'product_version=ts-1.1' -var 'platform=debian7' ../../aws/riak
```

### Provision clients instance

```bash
$ mkdir [TR-HOME]/working/clients
$ cd [TR-HOME]/working/clients
$ terraform apply -var 'platform=ubuntu14' ../../aws/clients
```

Take note of the public ips printed to the console at the end of each process.

### Destroying

To destroy provisioned infrastructure, simply replace 'apply' with 'destroy' in the commands above. Run the command from the relevant `working` subdirectory. For example:

```bash
$ cd [TR-HOME]/working/kv-2.1.3-rhel6
$ terraform destroy -var 'product_version=kv-2.1.3' -var 'platform=rhel6' ../../aws/riak

$ cd [TR-HOME]/working/ts-1.1-debian7
$ terraform destroy -var 'product-version=ts-1.1' -var 'platform=debian7' ../../aws/riak
```

### Remote command execution with Ansible

Ansible can be used to execute ad-hoc commands against the remote instances without manually logging in. 

You first need to activate ansible and import your key into ssh-agent:

```bash
$ source [ANSIBLE-HOME]/hacking/env-setup
$ ssh-agent bash
$ ssh-add [key_path]
```

Riak cluster command example:

```bash
$ RIAK_IP=[RIAK_IP]
$ ansible all -i "$RIAK_IP," -u "ec2-user" -m shell -a "sudo riak-admin member_status"
```

The commands below can be used to create sample data and execute queries against a Riak TS cluster:

```bash
$ CLIENT_IP=[CLIENT_IP]
$ RIAK_IP=[RIAK_IP]
$ ansible all -i "$RIAK_IP," -u "ec2-user" -m shell -a "bash ~/scripts/create_ts_bucket.sh GeoCheckin1"
$ ansible all -i "$RIAK_IP," -u "ec2-user" -m shell -a "bash ~/scripts/create_ts_bucket.sh GeoCheckin2"
$ ansible all -i "$RIAK_IP," -u "ec2-user" -m shell -a "bash ~/scripts/create_ts_bucket.sh GeoCheckin3"
$ ansible all -i "$CLIENT_IP," -u "ubuntu" -m shell -a "python -W ignore ./scripts/python/TSInsert.py $RIAK_IP GeoCheckin1"
$ ansible all -i "$CLIENT_IP," -u "ubuntu" -m shell -a "python -W ignore ./scripts/python/TSQuery.py $RIAK_IP GeoCheckin1"
$ ansible all -i "$CLIENT_IP," -u "ubuntu" -m shell -a "java -cp ./scripts/java:./riak-client-2.0.3-jar-with-dependencies.jar:./slf4j-1.7.12/slf4j-jdk14-1.7.12.jar TSInsert $RIAK_IP GeoCheckin2"
$ ansible all -i "$CLIENT_IP," -u "ubuntu" -m shell -a "java -cp ./scripts/java:./riak-client-2.0.3-jar-with-dependencies.jar:./slf4j-1.7.12/slf4j-jdk14-1.7.12.jar TSQuery $RIAK_IP GeoCheckin2"
$ ansible all -i "$CLIENT_IP," -u "ubuntu" -m shell -a "escript ./scripts/erlang/TSInsert $RIAK_IP GeoCheckin3"
$ ansible all -i "$CLIENT_IP," -u "ubuntu" -m shell -a "escript ./scripts/erlang/TSQuery $RIAK_IP GeoCheckin3"
```

Ansible ad-hoc commands require the target host's Linux user name (-u parameter above). Use "ec2-user" for RHEL-based instances, "ubuntu" for Ubuntu-based instances and "admin" for Debian-based instances.

