resource "aws_vpc" "this_vpc" {
  cidr_block = "${var.cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.name}-vpc"
  }
}

resource "aws_subnet" "this_public" {
  vpc_id = "${aws_vpc.this_vpc.id}"
  cidr_block = "${var.subnets_cidrs["public"]}"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.aws_region}a"
  tags {
    Name = "${var.name}-public-subnet"
  }
}

resource "aws_subnet" "this_private" {
  vpc_id = "${aws_vpc.this_vpc.id}"
  cidr_block = "${var.subnets_cidrs["private"]}"
  map_public_ip_on_launch = "false"
  availability_zone = "${var.aws_region}a"
  tags {
    Name = "${var.name}-private-subnet"
  }
}

resource "aws_internet_gateway" "this_gateway" {
  vpc_id = "${aws_vpc.this_vpc.id}"
  tags {
    Name = "${var.name}-internet-gateway"
  }
}

resource "aws_route_table" "this_route_table" {
  vpc_id = "${aws_vpc.this_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.this_gateway.id}"
  }
  tags {
    Name = "${var.name}-route-table"
  }
}

resource "aws_route_table_association" "this_route_table_association" {
  subnet_id = "${aws_subnet.this_public.id}"
  route_table_id = "${aws_route_table.this_route_table.id}"
}
