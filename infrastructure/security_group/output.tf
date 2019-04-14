output "open-security-group-id" {
  value = "${aws_security_group.this_open_security_group.id}"
}

output "public-security-group-id" {
  value = "${aws_security_group.this_public_security_group.id}"
}

output "private-security-group-id" {
  value = "${aws_security_group.this_private_security_group.id}"
}