output "s3-access-role-name" {
  value = "${aws_iam_role.this_s3_access_role.name}"
}