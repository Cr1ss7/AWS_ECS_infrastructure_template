#Creacion de role para el uso de ECS

data "aws_iam_policy_document" "ecs_task" {
version = "2012-10-17"
    statement {
        actions = ["sts:AssumeRole"]
        principals {
            type = "Service"
            identifiers = ["ecs-tasks.amazonaws.com"]
        }
    }
}

resource "aws_iam_role" "ecs_execution_role" {
    name = "ecs_execution_role"
    assume_role_policy = data.aws_iam_policy_document.ecs_task.json
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy_attachment" {
    role = aws_iam_role.ecs_execution_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "rds_full_role_policy_attachment" {
    role = aws_iam_role.ecs_execution_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}