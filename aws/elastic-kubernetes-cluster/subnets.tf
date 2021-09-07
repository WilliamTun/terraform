resource "aws_subnet" "public_1" {
  # The VPC ID.
  vpc_id = aws_vpc.main.id

  # The CIDR block for public subnet 1
  cidr_block = "192.168.0.0/18"

  # Availability Zone for public subnet 1
  availability_zone = "eu-west-2a"

  # Required for EKS. Instances launched into the subnet should be assigned public ip.
  map_public_ip_on_launch = true

  # A map of tags to assign to the resource
  tags = {
    Name                        = "public-eu-west-2a"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }

}


resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.64.0/18"
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true
  tags = {
    Name                        = "public-eu-west-2b"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }

}


resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.128.0/18"
  availability_zone = "eu-west-2a"
  tags = {
    Name                              = "private-eu-west-2a"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }

}


resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.192.0/18"
  availability_zone = "eu-west-2b"
  tags = {
    Name                              = "private-eu-west-2b"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }

}
