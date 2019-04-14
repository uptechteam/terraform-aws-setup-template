output "instance_ip" {
  value = "${aws_eip.this_ip.public_ip}"
}