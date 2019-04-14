resource "aws_iam_instance_profile" "this_instance_profile" {
  role = "${var.s3_bucket_access_role_name}"
}

resource "aws_key_pair" "this_key_pair" {
  key_name = "${var.project_name}-${var.env}-key"
  public_key = "${file("${var.ssh_key_path}")}"
}

resource "aws_instance" "this_instance" {
  ami = "${var.instance_ami}"
  instance_type = "${var.instance_type}"

  key_name = "${aws_key_pair.this_key_pair.key_name}"
  
  subnet_id = "${var.subnet_id}"
  iam_instance_profile = "${aws_iam_instance_profile.this_instance_profile.name}"

  vpc_security_group_ids = ["${var.security_groups}"]

  root_block_device {
    delete_on_termination = false
    volume_size = "${var.volume_size}"
  }

  tags {
    Name = "${var.project_name}-${var.env}"
    Environment = "${var.env}"
    Project = "${var.project_name}"
  }
}

resource "aws_eip" "this_ip" {
  vpc = true
  instance = "${aws_instance.this_instance.id}"
}

