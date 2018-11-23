# terraform init : Intializes various local settings and data that will be used by subsequent commands.
# terraform apply : Start builidn the configured infrastructure.

variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default = "us-east-2"
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "MyAWSResource" {
  ami           = "ami-0f65671a86f061fcd"
  instance_type = "t2.micro"

  tags {
    Name    = "Terraform Instance"
    Project = "Teraform Guide v2"
    Creator = "Kyle OBrien"
    Tool    = "Terraform"
  }
}
