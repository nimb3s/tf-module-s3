resource "aws_s3_object" "this" {
  # depends_on   = [aws_s3_bucket.s3_bucket_nimb3s]
  for_each     = fileset("${var.root_file_path}", var.file_pattern)
  bucket       = var.bucket_name
  key          = basename(each.value)
  source       = each.value
  etag         = filemd5("${each.value}")
  content_type = var.content_type
}
