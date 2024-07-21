variable "aws_region" {
  description = "The AWS region for the infrastructure"
  type        = string
  default     = "us-west-2"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}
variable "subnet" {
  default = "10.0.0.0/24"
}
variable "instance_type" {
  type    = string
  default = "t4g.micro"
}
variable "aws_availability_zone" {
  type    = string
  default = "us-west-2a"
}

variable "postgres_port" {
  description = "The PostgreSQL port number"
  type        = number
  default     = 5432
}

variable "postgres_database_name" {
  description = "The PostgreSQL database name"
  type        = string
  default     = "postgres"
}

variable "postgres_username" {
  description = "The PostgreSQL user name"
  type        = string
  default     = "admin"
}

variable "postgres_password" {
  description = "The PostgreSQL user password"
  type        = string
  default     = "password"
}

variable "postgres_identifier" {
  description = "The PostgreSQL instance identifier"
  type        = string
  default     = "postgresql"
}

variable "postgres_instance_name" {
  description = "The PostgreSQL instance name"
  type        = string
  default     = "postgresql"
}

variable "mongo_exposed_port" {
  description = "The MongoDB port to listen on"
  type        = number
  default     = 27017
}

