resource "aws_lb" "travelty_backend_lb" {
    name = "travelty-backend-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.alb_sg.id]
    subnets = [aws_subnet.public-1.id, aws_subnet.public-2.id]
    tags = var.tags
}

resource "aws_lb_target_group" "travelty_backend_target_group" {
    name = "travelty-backend-target-group"
    port = 80
    protocol = "HTTP"
    target_type = "ip"
    vpc_id = aws_vpc.vpc.id
    tags = var.tags
}

resource "aws_lb_listener" "travelty_backend_listener_http" {
    load_balancer_arn = aws_lb.travelty_backend_lb.arn
    port = 80 
    protocol = "HTTP"
    default_action {
        type = "forward"
        forward {
            target_group {
                arn = aws_lb_target_group.travelty_backend_target_group.arn
                weight = 100
            }
        }
    }
}

resource "aws_lb_listener" "travelty_backend_listener_https" {
    load_balancer_arn = aws_lb.travelty_backend_lb.arn
    port = 443 
    protocol = "HTTPS"
    default_action {
        type = "forward"
        forward {
            target_group {
                arn = aws_lb_target_group.travelty_backend_target_group.arn
                weight = 100
            }
        }
    }
}

resource "aws_security_group" "alb_sg" {
    name = "alb_sg"
    description = "Security group for ALB"
    vpc_id = aws_vpc.vpc.id
    ingress {
        from_port = 80
        to_port = 80
        description = "HTTP"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

