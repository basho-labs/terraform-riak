# riak-terraform

Provision Riak KV and TS clusters on EC2 with a single Terraform command. This also enables you to provision a separate instance pre-configured with the Python, Java and Erlang clients. Remote command execution with Ansible is also supported.

## Setup

### Install Terraform

See: [https://terraform.io/intro/getting-started/install.html](https://terraform.io/intro/getting-started/install.html).

### Install Ansible (optional)

See: [http://docs.ansible.com/ansible/intro_installation.html](http://docs.ansible.com/ansible/intro_installation.html).

### Clone

```bash
$ git clone https://github.com/basho-labs/terraform-riak.git
```

### AWS configuration

Access keys: [http://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html](http://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html)

Key pair: [http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)

Update the key_name, key_path, aws_access_key and aws_secret_key variables in aws/global.tf

## Usage

Create a 'working' directory, a per product/version/platform subdirectory and a clients subdirectory

```bash
$ cd terraform-riak
$ mkdir working
$ mkdir working/kv-2.0.6-rhel6
$ mkdir working/ts-1.0-ubuntu14
$ mkdir working/clients
```

### Provision the cluster(s) and the clients instance

```bash
$ cd working/kv-2.0.6-rhel6
$ terraform apply ../../aws/riak
```

Open another tab in your SSH client, then

```bash
$ cd working/ts-1.0-ubuntu14
$ terraform apply -var 'product-version=ts-1.0' -var 'platform=ubuntu14' ../../aws/riak
```

Open another tab, and

```bash
$ cd working/clients
$ terraform apply -var 'platform=ubuntu14' ../../aws/clients
```

