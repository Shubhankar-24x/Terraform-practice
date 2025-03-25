resource "aws_s3_bucket" "my-bucket" {
  
  #args

bucket = "s3-demo-bucket-from-terraform"
tags = {
  Name = "S3-demo-bucket-from-Terraform"
}



}