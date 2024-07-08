resource "azurerm_mysql_flexible_server" "mysql" {
  name                = var.mysql_server_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  administrator_login    = var.mysql_server_admin_username
  administrator_password = var.mysql_server_admin_password

  sku_name = "GP_Standard_D2ds_v4"
  version  = "8.0.21"

  backup_retention_days = 7
}

resource "azurerm_mysql_flexible_database" "mysql_db" {
  name                = var.mysql_database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
  depends_on          = [azurerm_mysql_flexible_server.mysql]
}


resource "azurerm_mysql_flexible_server_configuration" "require_secure_transport" {
  name                = "require_secure_transport"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  value               = "OFF"
  depends_on          = [azurerm_mysql_flexible_server.mysql]
}