provider "aws" {
    region = "us-east-1"
    

}
variable "subnet_cidr_block" {
    description = "subnet cidr block"
}

variable "vpc_cidr-block" {
    description = "vpc cidr block"
}

variable "environement" {
    description = "deployment environment"
}

resource "aws_vpc" "development-vpc" {
    cidr_block = var.vpc_cidr-block
    tags = {
        name: "development",
        vpc_env: "dev"
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = "us-east-1a"
    tags = {
        name: "subnet-1-dev"
    }
}

data  "aws_vpc"  "existing_vpc" {
    default = true
}

resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = "172.31.48.0/24"
    availability_zone = "us-east-1a"
    tags = {
        name: "subnet-2-default"
    }
}


output "dev-vpc-id" {
    value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-1.id 
}
