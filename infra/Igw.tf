# Internet GW for public subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-assignment.id

  tags = {
    Name = "internet gateway"
    Product = "assignment"
  }
}