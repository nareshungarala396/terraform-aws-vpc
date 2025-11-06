locals {
    common_tags = {
        Project = var.project_name
        Environment = var.environment
        terraform = true
    }

    common_sufix_name = "${var.project_name}-${var.environment}"  #roboshop-dev
}