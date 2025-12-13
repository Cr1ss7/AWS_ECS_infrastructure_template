#General variables
region = "us-east-1"
tags = {
    Environment = "dev"
    Project = "Travelty"
    Owner = "cr1ss7"
    IaC = "Terraform"
}
#RDS variables
RDS-Name = "traveltydb"
RDS-Instance-Username = "postgresadmin"
RDS-Instance-Password = "admin123"
RDS-Instance-Engine = "postgres"
RDS-Instance-Type = "db.t3.micro"
RDS-instance-version = "18.1"
RDS-storage-type = "gp2"
#Bastion variables
EC2-Bastion-Name = "travelty-bastion"
EC2-Bastion-Instance-Type = "t2.micro"
EC2-Bastion-Instance-Image = "ami-0fa3fe0fa7920f68e"
EC2-Bastion-Instance-Key = "ssh-key/bastion-key.pub"
#VPC variables
VPC-Name = "travelty-vpc"
VPC-CIDR-Block = "10.0.0.0/16"
VPC-private-Subnet-1 = "10.0.1.0/24"
VPC-public-Subnet-1 = "10.0.2.0/24"
VPC-private-Subnet-2 = "10.0.3.0/24"
VPC-public-Subnet-2 = "10.0.4.0/24"
#ALB variables
ALB-Name = "travelty-alb"
#ECS variables
ECS-Cluster-Name = "travelty-cluster"
#Provider variables
access_key = ""
secret_key = ""