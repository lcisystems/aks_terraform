# AKS Terraform Setup and Drupal Deployment Guide

This guide provides step-by-step instructions on how to set up Terraform on Windows, install Azure CLI, log in to your Azure subscription, clone the necessary repository, and deploy a Drupal application on AKS using Terraform and Helm.

## Prerequisites

- Windows OS
- Git installed
- Internet connection

## Step 1: Install Terraform on Windows

1. Download the Terraform zip file from the official Terraform website: [Terraform Downloads](https://www.terraform.io/downloads).
2. Extract the downloaded zip file to a directory.
3. Add the Terraform directory to your system's PATH environment variable:
   - Open Control Panel.
   - Go to System and Security > System.
   - Click on Advanced system settings.
   - Click on Environment Variables.
   - Under System variables, find the PATH variable and click Edit.
   - Add the path to the directory where Terraform is extracted.
4. Open a new Command Prompt and run `terraform -v` to verify the installation.

## Step 2: Install Azure CLI

1. Download the Azure CLI installer from the official Azure website: [Azure CLI Downloads](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
2. Run the installer and follow the instructions to complete the installation.
3. Open a new Command Prompt and run `az --version` to verify the installation.

## Step 3: Log In to Your Azure Subscription

1. Open Command Prompt.
2. Run the following command to log in to your Azure account:
   ```bash
   az login
3. A web browser will open, prompting you to sign in to your Azure account. Complete the sign-in process.

## Step 4: Clone the Repository
1. Open Command Prompt.
2. Run the following command to clone the repository:
   ```
   git clone https://github.com/lcisystems/aks_terraform.git
   ```
3. Change directory to the cloned repository:
   ```
   cd aks_terraform
   ```

## Step 5: Prepare Terraform Variables
1. Open the terraform.tfvars file in a text editor.
2. Update the required values and remove the sensitive information (passwords, database names):
```
resource_group_name_prefix  = "rg"
resource_group_name         = "<resource_group_name>"
resource_group_location     = "eastus"
mysql_server_name           = "<mysql_server_name>"
mysql_server_admin_username = "<mysql_server_admin_username>>"
mysql_server_admin_password = ""
mysql_database_name         = ""
azurerm_kubernetes_cluster_name = "<azurerm_kubernetes_cluster_name>"
azurerm_kubernetes_cluster_dns_prefix = "<azurerm_kubernetes_cluster_dns_prefix>"
node_count                  = 1
username                    = "<username>"
start_ip_address            = "0.0.0.0"
end_ip_address              = "255.255.255.255"

```
## Step 6: Initialize and Apply Terraform
1. Run the following commands in the root of the repository to initialize and apply Terraform:

```
terraform init
terraform plan -out main.tfplan
terraform apply "main.tfplan"
```

## Step 7: Configure Kubernetes
1. Export the kubeconfig to a file:
```
echo "$(terraform output kube_config)" > ./azurek8s
```
2. Open the azurek8s file in a text editor and remove any End of File characters.
Set the KUBECONFIG environment variable:

```
$env:KUBECONFIG = "./azurek8s"
```
## Step 8: Verify Kubernetes Nodes
1. Run the following command to verify the Kubernetes nodes:

```
kubectl get nodes
```

## Step 9: Create Namespace for Drupal

1. Create a namespace for Drupal:

```
kubectl create namespace drupal
```


## Step 10: Install Helm
1. Follow the instructions to install Helm from the official Helm website: Helm Installation.[HELM INSTALL](https://helm.sh/docs/intro/install/)

2. After helm install add the bitnami 

```
helm repo add bitnami https://charts.bitnami.com/bitnami

```

## Step 11: Prepare Helm Values File
1. Add the required values in the **drupal_values.yml** file  **<addyourownvalues>**
```
# drupal-values.yaml
drupalUsername: <drupalUsername>
drupalPassword: <yourpassword>
drupalEmail: <drupalEmail>
drupalDatabaseHost: <hostname>.mysql.database.azure.com
drupalDatabaseUser: <drupalDatabaseUser>
drupalDatabasePassword: 
drupalDatabaseName: 

mariadb:
  enabled: false

externalDatabase:
  host: <hostname>.mysql.database.azure.com
  user: <databaseusername>
  password: <password>
  database: <databasename>
  port: 3306

persistence:
  enabled: true
  storageClass: azurefile-csi
  accessModes:
    - ReadWriteOnce
  size: 20Gi

readinessProbe:
  httpGet:
    path: /user/login
    port: http
  initialDelaySeconds: 120
  timeoutSeconds: 5
  periodSeconds: 10
  failureThreshold: 6

livenessProbe:
  httpGet:
    path: /user/login
    port: http
  initialDelaySeconds: 120
  timeoutSeconds: 5
  periodSeconds: 10
  failureThreshold: 6

```
## Step 12: Install Drupal Using Helm
1. Run the following command to install Drupal using Helm:

```
helm install pt-drupal bitnami/drupal -f drupal-values.yaml -n drupal
```

## Step 13: Verify Drupal Deployment
1. Run the following command to verify the Drupal deployment:

```
kubectl get pods -n drupal
```

## Step 14: Delete drupal from AKS 

```
helm uninstall pt-drupal -n drupal 
```

## step 15: Clean Up 

For clean up run the following command:

```
terraform destroy
```
