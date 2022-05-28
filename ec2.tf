data "aws_ami" "linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "app_001_keypair" {
  key_name   = "${var.aws_environment}-${var.ec2_instance_app-001-keypair-name}"
  public_key = file(var.ec2_instance_app-001-keypair-path)
}

resource "aws_instance" "app_001" {
  count                  = var.instance_settings.app.count
  ami                    = data.aws_ami.linux.id
  instance_type          = var.instance_settings.app.instance_type
  subnet_id              = aws_subnet.subnet_001[count.index].id
  key_name               = aws_key_pair.app_001_keypair.key_name
  user_data              = file("./scripts/ec2/user_data.sh")
  vpc_security_group_ids = [aws_security_group.sg_app_001.id]

  tags = {
    Name = "${var.aws_environment}-${var.ec2_instance_app-001-tag-name}-${count.index}"
  }
}

resource "aws_eip" "app_001_eip" {
  count    = var.instance_settings.app.count
  instance = aws_instance.app_001[count.index].id
  vpc      = true

  tags = {
    Name = "${var.aws_environment}-${var.ec2_instance_app-001-eip-tag-name}-${count.index}"
  }
}
