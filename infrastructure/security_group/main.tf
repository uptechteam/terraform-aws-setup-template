# Fully Open SG
resource "aws_security_group" "this_open_security_group" {
  vpc_id = "${var.vpc_id}"
  name = "${var.name}-open"
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags{
    Name="${var.name}-open"
  }
}

# Reasonably open SG (only necessary ports)
resource "aws_security_group" "this_public_security_group" {
  vpc_id = "${var.vpc_id}"
  name = "${var.name}-public"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags{
    Name="${var.name}-public"
  }
}

resource "aws_security_group_rule" "public_rules" {
  count = "${length(var.public_ports)}"
  type = "ingress"
  from_port = "${element(var.public_ports, count.index)}"
  to_port = "${element(var.public_ports, count.index)}"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.this_public_security_group.id}"
}


# Private SG (Open only to subnets and given IPs)
resource "aws_security_group" "this_private_security_group" {
  vpc_id = "${var.vpc_id}"
  name = "${var.name}-private"
  
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["${var.whitelisted_cidrs}"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags{
    Name="${var.name}-private"
  }
}
