# provider "aws" {
#   region = "us-east-1"  # Replace with your desired region
# }

# resource "aws_s3_bucket" "example" {
#   bucket = var.bucket_name
#    acl    = "private"

#   tags = {
#     Name        = "MyBucket"
#     Environment = "Dev"
#   }
# }

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "jenkinstest-bucketsoeyint"

}
