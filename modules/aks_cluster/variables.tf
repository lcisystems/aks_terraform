variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "azurerm_kubernetes_cluster_name" {
  type        = string
  description = "Name of the cluster"
}

variable "azurerm_kubernetes_cluster_dns_prefix" {
  type        = string
  description = "Prefix of the cluster DNS."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
}
