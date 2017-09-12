provider "aws" {
  profile = salesdemo
}

module "vpc-server" {
  source = "./vpc"
  region  = "${var.server_region}"
  cidr_block = "10.0"
}

module "vpc-client" {
  source = "./vpc"
  region   = "${var.client_region}"
  cidr_block = "192.168"
}

module "iperf-server" {
  name = "Server"
  region  = "${var.server_region}"
  source = "./iperf"
  vpc = "${module.vpc-server.vpc_id}"
  subnet = "${module.vpc-server.public_subnet_id}"
  keypair = "AviatrixDemo"
  userdata = "${file("./iperf/server_userdata.txt")}"
}

module "iperf-client" {
  name = "Client"
  source = "./iperf"
  region   = "${var.client_region}"
  vpc = "${module.vpc-client.vpc_id}"
  subnet = "${module.vpc-client.public_subnet_id}"
  keypair = "AviatrixDemo"
  userdata = "${file("./iperf/client_userdata.txt")}"
}

output "iperf-client-private-ip" {
    value = "${module.iperf-client.private-ip}"
}

output "iperf-server-private-ip" {
    value = "${module.iperf-server.private-ip}"
}

output "iperf-server-public-ip" {
    value = "${module.iperf-server.public-ip}"
}

output "iperf-client-public-ip" {
    value = "${module.iperf-client.public-ip}"
}

module "iam_roles" {
  source = "github.com/AviatrixSystems/terraform-modules.git/iam_roles"
  region  = "${var.server_region}"
}

module "aviatrixcontroller" {
  source = "github.com/AviatrixSystems/terraform-modules.git/controller"
  region  = "${var.server_region}"
  vpc = "${module.vpc-server.vpc_id}"
  subnet = "${module.vpc-server.public_subnet_id}"
  keypair = "AviatrixDemo"
  ec2role = "${module.iam_roles.aviatrix-role-ec2}"
}

output "aviatrixcontroller-private-ip" {
  value = "${module.aviatrixcontroller.private-ip}"
}

output "aviatrixcontroller-public-ip" {
  value = "${module.aviatrixcontroller.public-ip}"
}

module "windows" {
  source = "./windows"
  region   = "${var.client_region}"
  vpc = "${module.vpc-client.vpc_id}"
  subnet = "${module.vpc-client.public_subnet_id}"
  keypair = "AviatrixDemo"
  userdata = "${file("./iperf/iperf_userdata.txt")}"
}
