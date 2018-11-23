# terraform init : Intializes various local settings and data that will be used by subsequent commands.
# terraform apply : Start builidn the configured infrastructure.
# terraform destroy : tears down all specified infrastucture

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

resource "aws_instance" "API_Server" {
  ami           = "ami-0f65671a86f061fcd"
  instance_type = "t2.micro"

  tags {
    Name    = "Terraform Instance"
    Project = "Teraform Guide v3"
    Creator = "Kyle OBrien"
    Tool    = "Terraform"
  }
}

resource "aws_eip" "API_IP" {
  instance = "${aws_instance.API_Server.id}"
  depends_on = ["aws_instance.API_Server"]
}
