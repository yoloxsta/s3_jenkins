provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "yoloxstaaaay"

  tags = {
    Name        = "MyS3Bucket"
    Environment = "Dev"
  }
}

