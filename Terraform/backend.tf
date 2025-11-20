terraform {
  backend "s3" {
    bucket  = "aws-jisanjuan"
    key     = "terraform.tfstate"
    region  = "us-west-1"
    encrypt = true
  }
}

