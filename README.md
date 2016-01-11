# terraform-riak

terraform-riak is a tool that allows you to provision Riak KV and TS clusters on EC2 with a single command. It also enables you to provision a separate instance pre-configured with the Python, Java and Erlang clients. Remote command execution with Ansible is supported as well.

## Setup

* [Install Terraform](https://terraform.io/intro/getting-started/install.html)
* [Install Ansible](http://docs.ansible.com/ansible/intro_installation.html)
* Clone this repo

```bash
$ git clone https://github.com/basho-labs/terraform-riak.git
```

* Configure AWS access

  * Access keys: [http://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html](http://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html)

  * Key pair: [http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)

  * Update the `key_name`, `key_path`, `aws_access_key` and `aws_secret_key` variables in aws/global.tf

## Usage

Create a `working` subdirectory to facilitate provisioning:

```bash
$ mkdir [TR-HOME]/working
```

### Security group

The terraform configuration expects the AWS security group 'riak' to be present. The following commands will create it:

```bash
$ mkdir [TR-HOME]/working/security
$ cd [TR-HOME]/working/security
$ terraform apply ../../aws/security
```

The `terraform` command references the location of the terraform config files. 

### Provision clusters and the clients instance

Create per product/version/platform subdirectories and a clients subdirectory:

```bash
$ mkdir [TR-HOME]/working/kv-2.0.6-rhel6
$ mkdir [TR-HOME]/working/ts-1.0-ubuntu14
$ mkdir [TR-HOME]/working/clients
```

Provision the first cluster:

```bash
$ cd [TR-HOME]/working/kv-2.0.6-rhel6
$ terraform apply ../../aws/riak
```

The product_version variable defaults to 'kv-2.0.6'. The platform variable defaults to 'rhel6'.

To provision the second cluster, open a second tab in your SSH client and run:

```bash
$ cd [TR-HOME]/working/ts-1.0-ubuntu14
$ terraform apply -var 'product-version=ts-1.0' -var 'platform=ubuntu14' ../../aws/riak
```

To provision the clients instance, open a third tab and run:

```bash
$ cd [TR-HOME]/working/clients
$ terraform apply -var 'platform=ubuntu14' ../../aws/clients
```

Take note of the public ips printed to the console at the end of each process.

### Destroying

To destroy provisioned infrastructure, simply replace 'apply' with 'destroy' in the commands above. Run the command from the relevant `home` directory:

```bash
$ cd [TR-HOME]/working/kv-2.0.6-rhel6
$ terraform destroy ../../aws/riak

$ cd [TR-HOME]/working/ts-1.0-ubuntu14
$ terraform destroy -var 'product-version=ts-1.0' -var 'platform=ubuntu14' ../../aws/riak
```

### Remote command execution with Ansible

Ansible ad-hoc commands can be used to execute commands against the remote instances without manually logging in. 

You first need to activate ansible and import your key into ssh-agent:

```bash
$ source ~/ansible/hacking/env-setup
$ ssh-agent bash
$ ssh-add [key_path]
```

Riak cluster command example

```bash
$ ansible all -i '[IP],' -u "ec2-user" -m shell -a "sudo riak-admin member_status"
```







