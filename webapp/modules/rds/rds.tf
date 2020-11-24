resource "aws_db_subnet_group" "rds_custom_subnet" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = data.aws_subnet_ids.database_vpc_subnets_ids.ids
  tags = {
    Name = "ey-db-subnet-group"
  }
}

#Create RDS DB
resource "aws_db_instance" "rds_eyassir_01" {
  allocated_storage       = var.db_storage
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.db_instance_type
  name                    = var.db_name
  username                = var.admin_user
  password                = var.db_password
  parameter_group_name    = "default.mysql8.0"
  skip_final_snapshot     = true
  backup_retention_period = 7
  db_subnet_group_name    = aws_db_subnet_group.rds_custom_subnet.id
  vpc_security_group_ids  = [aws_security_group.ey_allow_mysql.id]
}

#Create Security Group for rds  instance
resource "aws_security_group" "ey_allow_mysql" {
  name   = "ey-rds-mysql-sg"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ey-rds-sg-mysql"
  }

}
