module "resource_group" {
  source               = "./modules/resource_group"
  resource_group_name  = "${var.resource_group_name_prefix}-${var.resource_group_name}"
  resource_group_location = var.resource_group_location
}

module "mysql_server" {
  source                     = "./modules/mysql_server"
  resource_group_name        = module.resource_group.resource_group_name
  resource_group_location    = var.resource_group_location
  mysql_server_name          = var.mysql_server_name
  mysql_server_admin_username = var.mysql_server_admin_username
  mysql_server_admin_password = var.mysql_server_admin_password
  mysql_database_name        = var.mysql_database_name
  
  
}

module "mysql_server_firwall" {
  source                     = "./modules/firewall_rule"
  resource_group_name        = module.resource_group.resource_group_name
  mysql_server_name          = var.mysql_server_name
  start_ip_address           = var.start_ip_address
  end_ip_address             = var.end_ip_address
  depends_on                 = [module.mysql_server]
}



module "aks_cluster" {
  source                      = "./modules/aks_cluster"
  resource_group_name         = module.resource_group.resource_group_name
  resource_group_location     = var.resource_group_location
  azurerm_kubernetes_cluster_name = var.azurerm_kubernetes_cluster_name
  azurerm_kubernetes_cluster_dns_prefix = var.azurerm_kubernetes_cluster_dns_prefix
  node_count                  = var.node_count
  username                    = var.username
  depends_on = [module.resource_group]
}

output "mysql_server_name" {
  value = module.mysql_server.mysql_server_name
}

output "mysql_database_name" {
  value = module.mysql_server.mysql_database_name
}

output "mysql_server_admin_username" {
  value = module.mysql_server.mysql_server_admin_username
}

output "aks_cluster_name" {
  value = module.aks_cluster.kubernetes_cluster_name
}

output "client_certificate" {
  value     = module.aks_cluster.client_certificate
  sensitive = true
}

output "client_key" {
  value     = module.aks_cluster.client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = module.aks_cluster.cluster_ca_certificate
  sensitive = true
}

output "cluster_password" {
  value     = module.aks_cluster.cluster_password
  sensitive = true
}

output "cluster_username" {
  value     = module.aks_cluster.cluster_username
  sensitive = true
}

output "host" {
  value     = module.aks_cluster.host
  sensitive = true
}

output "kube_config" {
  value     = module.aks_cluster.kube_config
  sensitive = true
}

output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "key_data" {
  value = module.aks_cluster.key_data
}