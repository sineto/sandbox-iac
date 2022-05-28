## PROFILE
# AWS region where everything will be created
variable "aws_region" {
  default = "us-east-1"
}

# AWS CLI profile placed on ~/.aws/credentials 
variable "aws_profile" {
  type        = string
  description = "AWS CLI account profile configured locally"
}

variable "aws_environment" {
  type        = string
  description = "Define the environment of the infrastructure (ex.: dev, prod, etc.)"
}

## NETWORK
# Name tag for the VPC
variable "vpc_001_tag-name" {
  type    = string
  default = "Name tag for VPC"
}

# CIDR block attributed to the VPC
variable "vpc_001_cidr-block" {
  type        = string
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

# Name tag for the Internet Gateway
variable "igw_001_tag-name" {
  type        = string
  description = "Name tag defined to Internet Gateway"
}

# Default numbers of subnets to public and private ones
variable "subnet_count" {
  type        = map(number)
  description = "Number of subnets"
  default = {
    public  = 1,
    private = 2
  }
}

# Default CIDR blocks for public subnets
variable "public_subnet_cidr-blocks" {
  type        = list(string)
  description = "Available CIDR block for public subnets"
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24"
  ]
}

# Default CIDR blocks for private subnets
variable "private_subnet_cidr-blocks" {
  type        = list(string)
  description = "Available CIDR block for public subnets"
  default = [
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24",
    "10.0.104.0/24"
  ]
}

## SECURITY
# Define Security Group for apps tag name
variable "sg_app_001_tag-name" {
  type        = string
  description = "Name tag for the app Security Group"
}

# Define Security Group for databases tag name
variable "sg_db_100_tag-name" {
  type        = string
  description = "Name tag for the database Security Group"
}

## INSTANCES SETTINGS
variable "db_username" {
  type        = string
  description = "Database master user"
  sensitive   = true
}

variable "db_password" {
  type        = string
  description = "Database master user password"
  sensitive   = true
}

variable "db_subnet_group_name" {
  type        = string
  description = "Database subnet group name"
}

variable "instance_settings" {
  description = "Configuration settings"
  type        = map(any)
  default = {
    "database" = {
      allocated_storage     = 10
      max_allocated_storage = 20
      engine                = "postgres"
      envine_version        = "12.8"
      instance_class        = "db.t2.micro"
      db_name               = "database-name"
      skip_final_snapshot   = true
    },
    "app" = {
      count         = 1
      instance_type = "t2.micro"
    }
  }
}

variable "ec2_instance_app-001-keypair-name" {
  type        = string
  description = "EC2 keypair app name"
}

variable "ec2_instance_app-001-keypair-path" {
  type        = string
  description = "EC2 keypair path file"
}

variable "ec2_instance_app-001-tag-name" {
  type        = string
  description = "EC2 app name"
}

variable "ec2_instance_app-001-eip-tag-name" {
  type        = string
  description = "EC2 app name"
}
