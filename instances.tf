resource "aws_instance" "apache-1a" {
  ami = "ami-1a15c77b"
  instance_type = "t2.nano"
  key_name = "key_name"
  associate_public_ip_address = "true"
  vpc_security_group_ids = ["${aws_security_group.admin.id}","${aws_security_group.web.id}"]
  subnet_id = "${aws_subnet.vpc-1-subnet-1a.id}"
  tags {
    Name = "Apache-1a"
  }
}

resource "aws_instance" "apache-1c" {
  ami = "ami-1a15c77b"
  instance_type = "t2.nano"
  key_name = "key_name"
  associate_public_ip_address = "true"
  vpc_security_group_ids = ["${aws_security_group.admin.id}","${aws_security_group.web.id}"]
  subnet_id = "${aws_subnet.vpc-1-subnet-1c.id}"
  tags {
    Name = "Apache-1c"
  }
}

output "public ip of Apache-1a" {
  value = "${aws_instance.apache-1a.public_ip}"
}

output "public ip of Apache-1c" {
  value = "${aws_instance.apache-1c.public_ip}"
}
