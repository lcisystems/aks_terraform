variable "mysql_server_name" {
  description = "Name of the MySQL server"
  type        = string
}

variable "mysql_server_admin_username" {
  description = "Admin username for the MySQL server"
  type        = string
}

variable "mysql_server_admin_password" {
  description = "Admin password for the MySQL server"
  type        = string
  sensitive   = true
}

variable "mysql_database_name" {
  description = "Name of the MySQL database"
  type        = string
}

variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}
