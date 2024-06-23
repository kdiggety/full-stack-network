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

