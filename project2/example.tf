provider "aws" {
  profile    = "default"
  region     = "ap-northeast-1"
}

terraform {
  backend "s3" {
    bucket = "atlantis-tf-demo-project2"
    key    = "tfstate"
    region = "ap-northeast-1"
    profile = "tfmj"
    dynamodb_table = "atlantis-tf-demo-project2-state-lock"
  }
}

resource "aws_instance" "example" {
  count = 1
  ami           = "ami-09b68f5653871885f"
  instance_type = "t2.micro"
}

resource "aws_instance" "dependent_example" {
  depends_on = ["aws_instance.example"]
  ami           = "ami-09b68f5653871885f"
  instance_type = "t2.micro"
}

resource "null_resource" "example" {
  
}
