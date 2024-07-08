variable "resource_group_name_prefix" {
  type        = string
  description = "Prefix of the resource group name"
}

variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

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

variable "azurerm_kubernetes_cluster_name" {
  type        = string
  description = "Name of the cluster"
}

variable "azurerm_kubernetes_cluster_dns_prefix" {
  type        = string
  description = "Prefix of the cluster DNS."
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 1
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
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

