locals {
  sg_app_name = "${var.aws_environment}-${var.sg_app_001_tag-name}"
  sg_db_name  = "${var.aws_environment}-${var.sg_db_100_tag-name}"
}

resource "aws_security_group" "sg_app_001" {
  name        = local.sg_app_name
  description = "Security Group for app servers"

  vpc_id = aws_vpc.vpc_001.id

  ingress {
    description = "Allow all traffic through the HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow all traffic through HTTP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = local.sg_app_name
  }
}

resource "aws_security_group" "sg_db_100" {
  name        = local.sg_db_name
  description = "Security Group for databases"

  vpc_id = aws_vpc.vpc_001.id

  ingress {
    description     = "Allow PostgreSQL traffic from only the app Security Group"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_app_001.id]
  }

  tags = {
    Name = local.sg_db_name
  }
}
