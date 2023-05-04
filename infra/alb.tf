# Create Application load balancer in public subnet(this need to be accessible over internet)
resource "aws_lb" "alb_webserver" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public-assignment-1a.id,aws_subnet.public-assignment-1b.id]
  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}
# Allow traffic to ALB from internet over HTTP
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "allow traffic to alb"
  vpc_id      = aws_vpc.vpc-assignment.id

  ingress {
    description      = "allow traffic from internet to ALB"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "alb-sg"

  }
}
# Create target group with instances in private subnets
resource "aws_lb_target_group" "web_servers" {
  name     = "web-servers"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-assignment.id
}

# Create LB listener to HTTP and targes group is the group created above
resource "aws_lb_listener" "web_servers" {
  load_balancer_arn = aws_lb.alb_webserver.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_servers.arn
  }
}
