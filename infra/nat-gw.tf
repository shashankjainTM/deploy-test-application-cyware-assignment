# Create NAT-GW for private subnet 1a
resource "aws_nat_gateway" "nat-gw-for-private-1a" {
  allocation_id = aws_eip.nat-1a.id
  subnet_id     = aws_subnet.public-assignment-1a.id

  tags = {
    Name = "gw-NAT-1a"
  }
}
# Create an Elastic IP 
resource "aws_eip" "nat-1a" {
  vpc      = true
}


# Create NAT-GW for private subnet 1b
resource "aws_nat_gateway" "nat-gw-for-private-1b" {
  allocation_id = aws_eip.nat-1b.id
  subnet_id     = aws_subnet.public-assignment-1b.id

  tags = {
    Name = "gw-NAT-1b"
  }
}
# Create an Elastic IP
resource "aws_eip" "nat-1b" {
  vpc      = true
}
