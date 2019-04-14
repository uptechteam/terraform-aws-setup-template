output "ssm-db-username-arn" {
  value = "${aws_ssm_parameter.username.arn}"
}

output "ssm-db-password-arn" {
  value = "${aws_ssm_parameter.password.arn}"
}

output "db-host" {
  value = "${aws_db_instance.this_db.address}"
}

output "db-port" {
  value = "${aws_db_instance.this_db.port}"
}
