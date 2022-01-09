resource "aws_subnet" "public-1" {
  cidr_block              = "10.10.1.0/24"
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true
  tags = {
    Name                        = "public-eu-central-1a"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

resource "aws_subnet" "public-2" {
  cidr_block              = "10.10.2.0/24"
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true
  tags = {
    Name                        = "public-eu-central-1b"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

resource "aws_subnet" "private-1" {
  cidr_block        = "10.10.3.0/24"
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "eu-central-1a"
  tags = {
    Name                              = "private-eu-central-1a"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "private-2" {
  cidr_block        = "10.10.4.0/24"
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "eu-central-1b"
  tags = {
    Name                              = "private-eu-central-1b"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}