# terraform-riak

terraform-riak allows you to provision a Riak KV or a Riak TS cluster on EC2 with a single Terraform command. You can also provision a separate instance pre-configured with the Python, Java and Erlang clients.

## Setup

* Install Terraform: 

```bash
$ wget https://releases.hashicorp.com/terraform/0.6.8/terraform_0.6.8_linux_amd64.zip
$ unzip terraform_0.6.8_linux_amd64.zip
$ PATH=$PATH:[TERRAFORM_HOME]
```

* Clone terraform-riak: 

```bash
$ git clone https://github.com/basho-labs/terraform-riak.git
```

(The path to `terraform-riak` is hereafter referred to as `TR_HOME`)

* Configure AWS access

  * Access keys: [http://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html](http://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html)

  * SSH Key pair: [http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)

  * Update the `key_name`, `key_path`, `aws_access_key` and `aws_secret_key` variables in aws/global.tf

## Usage

Create a `working` subdirectory:

```bash
$ mkdir [TR_HOME]/working
```

### AWS security group

The Riak cluster terraform configuration expects the AWS security group 'riak' to be present. The following commands will create it:

```bash
$ mkdir [TR_HOME]/working/security
$ cd [TR_HOME]/working/security
$ terraform apply ../../aws/security
```

### Provision Riak

The `terraform apply` command takes the following variables:

* `product_version` (default: kv-2.1.3; options: kv-2.1.3, kv-2.0.6, ts-1.1, ts-1.0)
* `platform` (default: rhel6; options: rhel6, rhel7, ubuntu12, ubuntu14, debian7)
* `nodes` (default: 5; options: must be >= 3)
* `instance_type` (default: t2.medium; options: any AWS instance type)

The following will use the defaults to provision a Riak KV 2.1.3 cluster using the RHEL 6 package:

```bash
$ mkdir [TR_HOME]/working/kv-2.1.3-rhel6
$ cd [TR_HOME]/working/kv-2.1.3-rhel6
$ terraform apply ../../aws/riak
```

To provision a Riak KV 2.0.6 cluster using the Ubuntu 14 package, do:

```bash
$ mkdir [TR_HOME]/working/kv-2.0.6-ubuntu14
$ cd [TR_HOME]/working/kv-2.0.6-ubuntu14
$ terraform apply -var 'product_version=kv-2.0.6' -var 'platform=ubuntu14' ../../aws/riak
```

To provision a Riak TS cluster, do:

```bash
$ mkdir [TR_HOME]/working/ts-1.1-rhel7
$ cd [TR_HOME]/working/ts-1.1-rhel7
$ terraform apply -var 'product_version=ts-1.1' -var 'platform=rhel7' ../../aws/riak
```

To provision a clients instance:

```bash
$ mkdir [TR_HOME]/working/clients
$ cd [TR_HOME]/working/clients
$ terraform apply -var 'platform=ubuntu14' ../../aws/clients
```

Take note of the public ips printed to the console at the end of each process.

### Destroying

To destroy provisioned infrastructure, simply replace `apply` with `destroy` in the commands above. Run the command from the relevant `working` subdirectory. For example:

```bash
$ cd [TR_HOME]/working/kv-2.1.3-rhel6
$ terraform destroy -var 'product_version=kv-2.1.3' -var 'platform=rhel6' ../../aws/riak

$ cd [TR_HOME]/working/ts-1.1-debian7
$ terraform destroy -var 'product-version=ts-1.1' -var 'platform=debian7' ../../aws/riak
```

### Remote command execution with Ansible

Install & activate Ansible:

```bash
$ git clone git://github.com/ansible/ansible.git --recursive
$ source [ANSIBLE_HOME]/hacking/env-setup
$ ssh-agent bash
$ ssh-add [PATH_TO_SSH_KEY]
```

Command example:

```bash
$ RIAK_IP=[RIAK_IP]
$ ansible all -i "$RIAK_IP," -u "ec2-user" -m shell -a "sudo riak ping"
$ ansible all -i "$RIAK_IP," -u "ec2-user" -m shell -a "sudo riak-admin member_status"
```

Ansible ad-hoc commands require the target host's Linux user name (`-u` parameter above). Use `ec2-user` for RHEL-based instances, `ubuntu` for Ubuntu-based instances and `admin` for Debian-based instances.

