# This is the route table for public subnet to allow traffic from internet
resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.vpc-assignment.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Route-table-public"
    Product = "assignment"
  }
}

resource "aws_route_table_association" "public-route-1a-association" {
  subnet_id      = aws_subnet.public-assignment-1a.id
  route_table_id = aws_route_table.public-route.id
}
resource "aws_route_table_association" "public-route-1b-association" {
  subnet_id      = aws_subnet.public-assignment-1b.id
  route_table_id = aws_route_table.public-route.id
}
# This is the route table for private subnet which allow route to NAT-GW to allow applications to connect to internet

resource "aws_route_table" "private-route-1a" {
  vpc_id = aws_vpc.vpc-assignment.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-for-private-1a.id
  }

  tags = {
    Name = "Route-table-private-1a"
    Product = "assignment"
  }
}

resource "aws_route_table_association" "private-route-1a-association" {
  subnet_id      = aws_subnet.private-assignment-1a.id
  route_table_id = aws_route_table.private-route-1a.id
}

resource "aws_route_table" "private-route-1b" {
  vpc_id = aws_vpc.vpc-assignment.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-for-private-1b.id
  }

  tags = {
    Name = "Route-table-private-1b"
    Product = "assignment"
  }
}
resource "aws_route_table_association" "private-route-1b-association" {
  subnet_id      = aws_subnet.private-assignment-1b.id
  route_table_id = aws_route_table.private-route-1b.id
}
