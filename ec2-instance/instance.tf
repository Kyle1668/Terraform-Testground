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
    Project = "Teraform Guide v4"
    Creator = "Kyle OBrien"
    Tool    = "Terraform"
  }

  security_groups = ["${aws_security_group.terraform_security.name}"]

  depends_on = ["aws_security_group.terraform_security"]
}

resource "aws_eip" "API_IP" {
  instance   = "${aws_instance.API_Server.id}"
  depends_on = ["aws_instance.API_Server"]
}

resource "aws_security_group" "terraform_security" {
  name        = "terraform_group"
  description = "made with terraform"

  # Inbound Rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Terraform_Security_group"
  }
}
