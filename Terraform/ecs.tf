resource "aws_ecs_cluster" "travelty_backend_cluster" {
  name = "travelty-backend-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "travelty_backend_task" {
    family = "travelty-backend-cluster"
    network_mode = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu = "256"
    memory = "512"
    execution_role_arn = aws_iam_role.ecs_execution_role.arn
    container_definitions = jsonencode([
    {
      name      = "travelty-backend-container"
      image     = "${aws_ecr_repository.travelty_backend_repository.repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "travelty_backend_service" {
  name            = "travelty-backend-service"
  cluster         = aws_ecs_cluster.travelty_backend_cluster.id
  task_definition = aws_ecs_task_definition.travelty_backend_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [aws_subnet.private-1.id, aws_subnet.private-2.id]
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.travelty_backend_target_group.arn
    container_name   = "travelty-backend-container"
    container_port   = 80
  }
}

resource "aws_security_group" "ecs_sg" {
    name = "ecs_sg"
    description = "Security group for ECS"
    vpc_id = aws_vpc.vpc.id
    ingress {
        from_port = 80
        to_port = 80
        description = "HTTP"
        protocol = "tcp"
        security_groups = [aws_security_group.alb_sg.id]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}