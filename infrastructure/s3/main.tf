resource "aws_s3_bucket" "this_bucket" {
  bucket = "${var.bucket_name}"
  region = "${var.aws_region}"
  acl = "private"

  versioning {
    enabled = true
  }
}

# Give full access to the bucket to the user 

resource "aws_s3_bucket_policy" "this_bucket_policy" {
  bucket = "${aws_s3_bucket.this_bucket.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${var.user_arn}"
      },
      "Action": [ "s3:*" ],
      "Resource": [
        "${aws_s3_bucket.this_bucket.arn}",
        "${aws_s3_bucket.this_bucket.arn}/*"
      ]
    }
  ]
}
EOF
}


# Policy to make instance access bucket without keys

resource "aws_iam_role" "this_s3_access_role" {
    name = "s3-bucket-${var.bucket_name}-access-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole", 
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }, 
      "Effect": "Allow", 
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "this_s3_access_policy" {
    name        = "s3-bucket-${var.bucket_name}-access-policy"
    description = "Policy to make instace access given S3 bucket"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket"
      ],
      "Resource": [
        "${aws_s3_bucket.this_bucket.arn}"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "${aws_s3_bucket.this_bucket.arn}/*"
      ]
    }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "this_role_policy_attachment" {
    role       = "${aws_iam_role.this_s3_access_role.name}"
    policy_arn = "${aws_iam_policy.this_s3_access_policy.arn}"
}