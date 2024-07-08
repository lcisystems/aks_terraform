
variable "mysql_server_name" {
  description = "Name of the MySQL server"
  type        = string
}


variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "start_ip_address" {
  type        = string
  description = "firewall rule starts with ip"
  default     = "0.0.0.0"
}

variable "end_ip_address" {
  type        = string
  description = "firewall rule ends with ip"
  default     = "255.255.255.255"
}

