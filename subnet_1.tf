resource "aws_subnet" "Websubnet-1" {
  vpc_id                  = "${aws_vpc.ProjectVpc.id}"
  cidr_block             = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-2a"

  tags = {
    Name = "Subnet 1"
  }
}

resource "aws_subnet" "Websubnet-2" {
  vpc_id                  = "${aws_vpc.ProjectVpc.id}"
  cidr_block             = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-2b"

  tags = {
    Name = "Subnet 2"
  }
}

resource "aws_subnet" "DatabaseSubnet-1" {
  vpc_id                  = "${aws_vpc.ProjectVpc.id}"
  cidr_block             = "10.0.3.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "Database Subnet 1"
  }
}

resource "aws_subnet" "DatabaseSubnet-2" {
  vpc_id                  = "${aws_vpc.ProjectVpc.id}"
  cidr_block             = "10.0.4.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name = "Database Subnet 2"
  }
}