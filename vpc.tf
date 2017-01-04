#
# VPC
#
resource "aws_vpc" "vpc-1" {
    cidr_block = "10.0.0.0/16"
    tags {
        Name = "vpc-1"
    }
}

#
# Internet Gateway
#
resource "aws_internet_gateway" "vpc-1-igw" {
    vpc_id = "${aws_vpc.vpc-1.id}"
    tags {
        Name = "vpc-1-igw"
    }
}

#
# Subnets
#
resource "aws_subnet" "vpc-1-subnet-1a" {
    vpc_id = "${aws_vpc.vpc-1.id}"
    cidr_block = "10.0.10.0/24"
    availability_zone = "ap-northeast-1b"
    tags {
        Name = "vpc-1-subnet-1b"
    }
}

resource "aws_subnet" "vpc-1-subnet-1c" {
    vpc_id = "${aws_vpc.vpc-1.id}"
    cidr_block = "10.0.20.0/24"
    availability_zone = "ap-northeast-1c"
    tags {
        Name = "vpc-1-subnet-1c"
    }
}

resource "aws_subnet" "vpc-1-subnet-db-1a" {
    vpc_id = "${aws_vpc.vpc-1.id}"
    cidr_block = "10.0.30.0/24"
    availability_zone = "ap-northeast-1b"
    tags {
        Name = "vpc-1-subnet-db-1b"
    }
}

resource "aws_subnet" "vpc-1-subnet-db-1c" {
    vpc_id = "${aws_vpc.vpc-1.id}"
    cidr_block = "10.0.40.0/24"
    availability_zone = "ap-northeast-1c"
    tags {
        Name = "vpc-1-subnet-db-1c"
    }
}

resource "aws_db_subnet_group" "main" {
    name        = "db_subnet"
    description = "DB subnet group on vpc."
    subnet_ids  = ["${aws_subnet.vpc-1-subnet-db-1a.id}", "${aws_subnet.vpc-1-subnet-db-1c.id}"]
    tags {
        Name = "db_subnet"
    }
}

#
# Routes Table
#
resource "aws_route_table" "vpc-1-public-rt" {
    vpc_id = "${aws_vpc.vpc-1.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.vpc-1-igw.id}"
    }
    tags {
        Name = "vpc-1-public-rt"
    }
}

resource "aws_route_table_association" "vpc-1-rta-1a" {
    subnet_id = "${aws_subnet.vpc-1-subnet-1a.id}"
    route_table_id = "${aws_route_table.vpc-1-public-rt.id}"
}

resource "aws_route_table_association" "vpc-1-rta-1c" {
    subnet_id = "${aws_subnet.vpc-1-subnet-1c.id}"
    route_table_id = "${aws_route_table.vpc-1-public-rt.id}"
}
