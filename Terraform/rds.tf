resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "juanwordpress-rds-subnet-group"
  subnet_ids = [for s in aws_subnet.private : s.id]
  tags       = { Name = "JuanWordpress-rds-subnet-group" }
}

resource "aws_db_instance" "postgres" {
  identifier             = "juanwordpres-postgres"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "15.15"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  multi_az               = false
  skip_final_snapshot    = true
  publicly_accessible    = false
  storage_encrypted      = true
  deletion_protection    = false

  tags = { Name = "JuanWordpress-postgres" }
}
