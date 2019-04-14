resource "aws_s3_bucket" "state_bucket" {
  bucket = "${var.project_name}-terraform-state-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }
}