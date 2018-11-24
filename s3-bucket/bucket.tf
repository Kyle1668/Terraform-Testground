variable "access_key" {}
variable "secret-key" {}

variable "region" {
  default = "us-east-2"
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret-key}"
  region     = "${var.region}"
}

resource "aws_s3_bucket" "MyAWSResource" {
  name = "terraform-test-kyle-bucket"
  acl  = "private"

  versioning {
    enabled = true
  }

  tags {
    Name    = "Terraform S3"
    Project = "Teraform Guide v4"
    Creator = "Kyle OBrien"
    Tool    = "Terraform"
  }
}
