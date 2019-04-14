resource "aws_db_subnet_group" "this_db_subnet_group" {
  name = "${var.name}_${var.env}_subnet_group"
  subnet_ids = [
    "${var.subnet_ids}"]

  tags {
    Name = "${var.name} ${var.env} subnet group"
  }
}

resource "aws_db_instance" "this_db" {
  identifier = "${var.name}-${var.env}"
  allocated_storage = "30"
  engine = "postgres"
  engine_version = "10.6"
  instance_class = "db.t2.micro"
  publicly_accessible = true
  name = "${var.db_name}"
  username = "${var.username}"
  password = "${var.password}"
  vpc_security_group_ids = [
    "${var.security_group_ids}"
  ]
  db_subnet_group_name = "${aws_db_subnet_group.this_db_subnet_group.id}"
  skip_final_snapshot = "true"
  backup_retention_period = 7

  tags {
    Project = "${var.name}"
    Environment = "${var.env}"
  }
}

resource "aws_ssm_parameter" "username" {
  name = "/${var.name}/${var.env}/database/username"
  type = "SecureString"
  value = "${var.username}"

  tags {
    Name = "${var.name}_${var.env}_postgres_username"
  }
}

resource "aws_ssm_parameter" "password" {
  name = "/${var.name}/${var.env}/database/password"
  type = "SecureString"
  value = "${var.password}"

  tags {
    Name = "${var.name}_${var.env}_postgres_password"
  }
}
