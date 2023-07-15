provider "aws" {
  access_key = "test"
  secret_key = "test"
  region     = "us-east-1"
  s3_use_path_style           = false
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = false

  endpoints {
    s3 = "http://s3.localhost.localstack.cloud:4566"
  }
}

module "aws_s3_account_public_access_block" {
  source = "../../modules/s3-account-public-access"
  # account_id = data.aws_caller_identity.current.account_id
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false 
}

module "my_static_website_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name = var.bucket_name
  block_public_acls = var.block_public_acls
  block_public_policy = var.block_public_policy
  ignore_public_acls = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

module "bucket_objects" {
  for_each = {
    root_files = {
      path_root = "${path.root}"
      pattern = "www/**.html"
      content_type = "text/html"
    }
  }
  source = "../../modules/s3-object"

  root_file_path = lookup(each.value, "path_root")
  file_pattern = lookup(each.value, "pattern")
  content_type = lookup(each.value, "content_type")
  bucket_name =  var.bucket_name
}