#Modificar en caso de usar un backend remoto
terraform{
    backend "local" {
        path = "terraform.tfstate"
    }
}


#backend "s3" {
#    bucket = "terraform-state-bucket"
#    key = "terraform.tfstate"
#    region = "us-east-1"
#}