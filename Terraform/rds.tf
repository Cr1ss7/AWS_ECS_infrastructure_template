resource "aws_db_instance" "rds" {
    instance_class = var.RDS-Instance-Type
    engine = var.RDS-Instance-Engine
    username = var.RDS-Instance-Username
    password = var.RDS-Instance-Password
    engine_version = var.RDS-instance-version
    db_name = var.RDS-Name
    allocated_storage = 20
    storage_type = var.RDS-storage-type
    skip_final_snapshot = true
    vpc_security_group_ids = [aws_security_group.rds_sg.id]
    db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
    tags = {
        Name = var.RDS-Name
        Environment = var.tags.Environment
        Project = var.tags.Project
        Owner = var.tags.Owner
        IaC = var.tags.IaC
    } 
}

resource "aws_db_subnet_group" "rds_subnet_group" {
    name = "${var.RDS-Name}-subnet-group"
    subnet_ids = [aws_subnet.private-1.id, aws_subnet.private-2.id]
}

resource "aws_security_group" "rds_sg" {
    description = "Security group for RDS"
    vpc_id = aws_vpc.vpc.id
    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        security_groups = [aws_security_group.bastion_sg.id]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = var.RDS-Name
        Environment = var.tags.Environment
        Project = var.tags.Project
        Owner = var.tags.Owner
        IaC = var.tags.IaC
    } 
}