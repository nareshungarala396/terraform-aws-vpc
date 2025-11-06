variable "vpc_cidr" {
    type = string
    description = "please provide cidr value"
}

variable "project_name" {
    type = string 
}

variable "environment" {
    type = string
}

variable "vpc_tags" {
    type = map
    default = { }
}


    