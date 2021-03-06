# terraform-pipeline-az-storage-test

Azure Storage Account with terraform

Minimal requirements to run manually.

- Azure Subscription (ARM_SUBSCRIPTION_ID)
- Azure Tenant (ARM_TENANT_ID)
- Azure Service Principal (ARM_CLIENT_ID)
- Azure Certificate Associated with Service Principal (ARM_CLIENT_CERTIFICATE_PATH)
- Azure Storage Account
  - Azure container in storage account
  - Azure Storage Account Access Key (ARM_ACCESS_KEY) - for Terraform Remote Backend.

Once you have all the info export it as environment variables.

```bash
export ARM_CLIENT_ID="00000000-0000-0000-0000-000000000000"
export ARM_CLIENT_CERTIFICATE_PATH="/your/path/file.pfx"
export ARM_SUBSCRIPTION_ID="00000000-0000-0000-0000-000000000000"
export ARM_TENANT_ID="00000000-0000-0000-0000-000000000000"
export ARM_ACCESS_KEY='XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
export TF_VAR_prefix=WHATYOUWANT
```

**Note**: Change the backend configuration in [main.tf](main.tf) to point to your configuration.

```
# define your own storage_account_name and export ARM_ACCESS_KEY
terraform {
  backend "azurerm" {
    resource_group_name  = "yourRG"
    storage_account_name = "yourStorageAccount"
    container_name       = "yourcontainer"
    key                  = "whatyouwant.tfstate"
  }
}
```