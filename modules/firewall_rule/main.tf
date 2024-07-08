resource "azurerm_mysql_flexible_server_firewall_rule" "firewall_rule" {
  name                = "all"
  resource_group_name = var.resource_group_name
  server_name         = var.mysql_server_name
  start_ip_address    = var.start_ip_address
  end_ip_address      = var.end_ip_address

}

resource "azurerm_mysql_flexible_server_firewall_rule" "allow_azure_services" {
  name                = "AllowAzureServices"
  resource_group_name = var.resource_group_name
  server_name         = var.mysql_server_name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}