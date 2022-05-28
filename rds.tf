resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "${var.aws_environment}-${var.db_subnet_group_name}"
  description = "DB subnet group for databases"

  subnet_ids = [for subnet in aws_subnet.subnet_100 : subnet.id]
}

resource "aws_db_instance" "database_001" {
  identifier        = var.instance_settings.database.db_name
  allocated_storage = var.instance_settings.database.allocated_storage
  engine            = var.instance_settings.database.engine
  engine_version    = var.instance_settings.database.engine_version
  instance_class    = var.instance_settings.database.instance_class

  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id
  vpc_security_group_ids = [aws_security_group.sg_db_100.id]

  skip_final_snapshot = var.instance_settings.database.skip_final_snapshot

  tags = {
    Name = var.instance_settings.database.db_name
  }
}

## after all infrastructure previsioned
## 1. connect to database to see if the database can be successfully access
# $ sudo psql -h <database-endpoint>.us-east-1.rds.amazonaws.com -U dbadmin -d postgres
