resource "aws_eip" "nat-1" {
}

resource "aws_eip" "nat-2" {
}

resource "aws_nat_gateway" "gw-1" {
  allocation_id = aws_eip.nat-1.id
  subnet_id     = aws_subnet.public-1.id
  tags = {
    Name = "NAT-1"
  }
}

resource "aws_nat_gateway" "gw-2" {
  allocation_id = aws_eip.nat-2.id
  subnet_id     = aws_subnet.public-2.id
  tags = {
    Name = "NAT-2"
  }
}
