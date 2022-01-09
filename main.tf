terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  backend "remote" {
    organization = "epam-course"

    workspaces {
      name = "epam_terraform"
    }
  }
}

provider "aws" {
  region     = "${var.REGION}"
  access_key = "${var.AWS_ACCESS_KEY_ID}"
  secret_key = "${var.AWS_SECRET_ACCESS_KEY}"
}