resource "aws_security_group" "allow_all" {
  vpc_id = "${aws_vpc.vpc-1.id}"
  name = "allow-all"
  description = "Allow all inbound traffic"
  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "allow-all"
  }
}

#
# not used
#
resource "aws_security_group" "allow_ssh_http" {
  vpc_id = "${aws_vpc.vpc-1.id}"
  name = "allow_ssh_http"
  description = "Allow ssh and http inbound traffic"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["121.121.121.121/32"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "allow-ssh-http"
  }
}

#
# admin(ssh)
#
resource "aws_security_group" "admin" {
    name = "admin"
    description = "Allow SSH inbound traffic"
    vpc_id = "${aws_vpc.vpc-1.id}"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
      Name = "admin"
    }
}

#
# web(http/https)
#
resource "aws_security_group" "web" {
    name = "web"
    description = "Allow Web inbound traffic"
    vpc_id = "${aws_vpc.vpc-1.id}"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
      Name = "web"
    }
}



#
# db
#
resource "aws_security_group" "db" {
    name = "db"
    description = "Allow DB inbound traffic"
    vpc_id = "${aws_vpc.vpc-1.id}"
    tags {
      Name = "db"
    }
}
resource "aws_security_group_rule" "db" {
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.web.id}"
  security_group_id = "${aws_security_group.db.id}"
}
