output "app_public_api" {
  value      = aws_eip.app_001_eip[0].public_ip
  depends_on = [aws_eip.app_001_eip]
}

output "app_public_dns" {
  value      = aws_eip.app_001_eip[0].public_dns
  depends_on = [aws_eip.app_001_eip]
}

output "database_endpoint" {
  value = aws_db_instance.database_001.address
}

output "database_port" {
  value = aws_db_instance.database_001.port
}
