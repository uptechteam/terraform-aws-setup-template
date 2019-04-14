resource "aws_iam_user" "this_user" {
  name = "${var.username}"
}

resource "aws_iam_access_key" "this_user_access_keys" {
  user = "${aws_iam_user.this_user.name}"
}

