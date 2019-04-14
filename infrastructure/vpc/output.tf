output "public-subnet-id" {
  value = "${aws_subnet.this_public.id}"
}

output "private-subnet-id" {
  value = "${aws_subnet.this_private.id}"
}

output "public-subnet-cidr" {
  value = "${aws_subnet.this_public.cidr_block}"
}

output "private-subnet-cidr" {
  value = "${aws_subnet.this_private.cidr_block}"
}


output "vpc-id" {
  value = "${aws_vpc.this_vpc.id}"
}