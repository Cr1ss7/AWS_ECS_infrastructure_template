resource "aws_instance" "bastion" {
    ami = var.EC2-Bastion-Instance-Image
    instance_type = var.EC2-Bastion-Instance-Type
    associate_public_ip_address = true
    subnet_id = aws_subnet.public-1.id
    security_groups = [aws_security_group.bastion_sg.id]
    key_name = aws_key_pair.bastion_key.key_name
    tags = {
        Name = var.EC2-Bastion-Name
        Environment = var.tags.Environment
        Project = var.tags.Project
        Owner = var.tags.Owner
        IaC = var.tags.IaC
    } 
}

resource "aws_key_pair" "bastion_key" {
    key_name = "${var.EC2-Bastion-Name}-key"
    public_key = file(var.EC2-Bastion-Instance-Key)
}

resource "aws_security_group" "bastion_sg" {
    name = var.EC2-Bastion-Name
    description = "Security group for bastion host"
    vpc_id = aws_vpc.vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = var.EC2-Bastion-Name
        Environment = var.tags.Environment
        Project = var.tags.Project
        Owner = var.tags.Owner
        IaC = var.tags.IaC
    } 
}

resource "aws_eip" "bastion_eip" {
    domain = "vpc"
    instance = aws_instance.bastion.id
    tags = var.tags
}
