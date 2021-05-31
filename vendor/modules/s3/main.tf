resource "aws_s3_bucket" "this" {
  bucket = var.bucket # If omitted, Terraform will assign a random, unique name.
  acl =    var.acl
}
