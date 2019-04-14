output "iam_user_arn" {
  value = "${aws_iam_user.this_user.arn}"
}

output "iam_access_key_id" {
  value = "${aws_iam_access_key.this_user_access_keys.id}"
}

output "iam_access_key_secret" {
  value = "${aws_iam_access_key.this_user_access_keys.secret}"
}