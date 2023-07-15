resource "aws_s3_bucket" "this_aws_s3_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "this_aws_s3_bucket_public_access_block" {
  bucket = resource.aws_s3_bucket.this_aws_s3_bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}