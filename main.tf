terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.16.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "postgresql" {
  host            = aws_db_instance.postgres.address
  port            = var.postgres_port
  database        = var.postgres_database_name
  username        = var.postgres_username
  password        = var.postgres_password
  sslmode         = "require"
  connect_timeout = 15
  superuser       = false
}

// POSTGRES
resource "aws_security_group" "postgres_security_group_name" {
  name = "postgres_security_group_name"

  ingress {
    from_port   = var.postgres_port
    to_port     = var.postgres_port
    protocol    = "tcp"
    description = "PostgreSQL"
    cidr_blocks = ["0.0.0.0/0"] // >
  }

  ingress {
    from_port        = var.postgres_port
    to_port          = var.postgres_port
    protocol         = "tcp"
    description      = "PostgreSQL"
    ipv6_cidr_blocks = ["::/0"] // >
  }
}

resource "aws_db_instance" "postgres" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "12.2"
  instance_class         = "db.t2.micro"
  identifier             = var.postgres_identifier
  db_name                = var.postgres_instance_name
  username               = var.postgres_username
  password               = var.postgres_password
  publicly_accessible    = true
  parameter_group_name   = "default.postgres12"
  vpc_security_group_ids = [aws_security_group.postgres_security_group_name.id]
  skip_final_snapshot    = true
}

resource "postgresql_role" "username" {
  name                = var.postgres_username
  login               = true
  password            = var.postgres_password
  encrypted_password  = true
  create_database     = true
  create_role         = true
  skip_reassign_owned = true
}
