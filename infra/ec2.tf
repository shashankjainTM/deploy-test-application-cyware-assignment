resource "aws_instance" "web-server-1a" {
  ami             = "ami-0067a5ac65b10cc84" 
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private-assignment-1a.id #subnet is private in eu-central-1a
  associate_public_ip_address = false # no need too create public ip's as this instance is reachable only via private address
  security_groups = [aws_security_group.web-ec2-sg.id] 
  user_data       = file("user_data.sh")
  key_name        = "test-delete-console" 

  credit_specification {
    cpu_credits = "unlimited"
  }
  tags = {
    Name = "assignment-web-server-1a"
    product = "assignment"
  }

}
resource "aws_instance" "web-server-1b" {
  ami             = "ami-0067a5ac65b10cc84"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private-assignment-1b.id #subnet is private in eu-central-1b
  associate_public_ip_address = false # no need too create public ip's as this instance is reachable only via private address
  security_groups = [aws_security_group.web-ec2-sg.id]
  user_data       = file("user_data.sh")
  key_name        = "test-delete-console" 

  credit_specification {
    cpu_credits = "unlimited"
  }
  tags = {
    Name = "assignment-web-server-1b"
    product = "assignment"
  }

}

# Security Group to allow ingress from ALB and EC2 instance in public subnet
resource "aws_security_group" "web-ec2-sg" {
  name        = "web-ec2-SG"
  description = "allow traffic to web server"
  vpc_id      = aws_vpc.vpc-assignment.id

  ingress {
    description      = "allow traffic from private and ALB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc-assignment.cidr_block]
  }
  ingress {
    description      = "allow traffic from public for ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = ["sg-0d35f51e2c45ff2df"] 
  }
  ingress {
    description      = "allow traffic from alb"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb_sg.id] 
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "web-ec2-sg"
  }
}