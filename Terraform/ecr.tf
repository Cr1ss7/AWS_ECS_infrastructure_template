resource "aws_ecr_repository" "travelty_backend_repository"{
    name = "travelty-backend"
    image_tag_mutability = "MUTABLE"
    force_delete = true
    image_scanning_configuration {
        scan_on_push = true
    }
}