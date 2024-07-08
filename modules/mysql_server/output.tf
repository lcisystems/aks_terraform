output "mysql_server_name" {
  description = "Name of the MySQL server"
  value       = azurerm_mysql_flexible_server.mysql.name
}

output "mysql_database_name" {
  description = "Name of the MySQL database"
  value       = azurerm_mysql_flexible_database.mysql_db.name
}

output "mysql_server_admin_username" {
  description = "Admin username for the MySQL server"
  value       = azurerm_mysql_flexible_server.mysql.administrator_login
}
