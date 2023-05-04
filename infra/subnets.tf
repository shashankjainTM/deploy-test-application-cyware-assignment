#This is a public subnets in eu-central-1a and eu-central-1b
resource "aws_subnet" "public-assignment-1a" {
  vpc_id     = aws_vpc.vpc-assignment.id
  cidr_block = "10.0.0.0/24"
  availability_zone  = "eu-central-1a"

  tags = {
    Name = "public-subnet-1a"
    Product = "assignment"
  }
}

resource "aws_subnet" "public-assignment-1b" {
  vpc_id     = aws_vpc.vpc-assignment.id
  cidr_block = "10.0.1.0/24"
  availability_zone  = "eu-central-1b"

  tags = {
    Name = "public-subnet-1b"
    Product = "assignment"
  }
}


#This is a private subnets in eu-central-1a and eu-central-1b
resource "aws_subnet" "private-assignment-1a" {
  vpc_id     = aws_vpc.vpc-assignment.id
  cidr_block = "10.0.2.0/24"
  availability_zone  = "eu-central-1a"

  tags = {
    Name = "private-subnet-1a"
    Product = "assignment"
  }
}

resource "aws_subnet" "private-assignment-1b" {
  vpc_id     = aws_vpc.vpc-assignment.id
  cidr_block = "10.0.3.0/24"
  availability_zone  = "eu-central-1b"

  tags = {
    Name = "private-subnet-1b"
    Product = "assignment"
  }
}