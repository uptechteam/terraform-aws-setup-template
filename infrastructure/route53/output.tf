output "domain_name" {
  value = "${aws_route53_record.this_record.name}"
}
