#Infraestructura creada usando los servicios de contenedores de AWS como ECS, ECR y RDS
#Ademas, se utulizara ECS en modo Fargate para la creacion de contenedores para que sea completamente sertverless
#Autor: Cristian Pineda 
#Fecha: 2025-12-06
#Version: 1.0

variable "region" {
    type = string
}

variable "tags" {
    type = map(string)
}

#RDS variables
variable "RDS-Name" {
    type = string
}

variable "RDS-Instance-Username" {
    type = string
}

variable "RDS-Instance-Password" {
    type = string
}

variable "RDS-Instance-Engine" {
    type = string
}

variable "RDS-Instance-Type" {
    type = string
}

variable "RDS-instance-version" {
    type = string
}

variable "RDS-storage-type" {
    type = string
}

#Bastion variables
variable "EC2-Bastion-Name" {
    type = string
}

variable "EC2-Bastion-Instance-Type" {
    type = string
}

variable "EC2-Bastion-Instance-Image" {
    type = string
}

variable "EC2-Bastion-Instance-Key" {
    type = string
}

#VPC variables
variable "VPC-Name" {
    type = string
}

variable "VPC-CIDR-Block" {
    type = string
}

variable "VPC-private-Subnet-1" {
    type = string
}

variable "VPC-public-Subnet-1" {
    type = string
}

variable "VPC-private-Subnet-2" {
    type = string
}

variable "VPC-public-Subnet-2" {
    type = string
}

variable "ALB-Name" {
    type = string
}

#ECS variables
variable "ECS-Cluster-Name" {
    type = string
}

#varibles for provider
variable "access_key" {
    type = string
}

variable "secret_key" {
    type = string
}