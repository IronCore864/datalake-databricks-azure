# Databricks and Datalake configuration

## Configure

Create a new file `cfg.ini` based on `cfg.ini.template` with your desired values

Create a new file `config.tf` based on `config.tf.template` with Azure account info

Run `make deployDev` (for prod, `make deployProd`) to generate templates and install script for "dev" env defined in the `cfg.ini` file and run those same scripts.

### Creating Service Principal

We need a service principal for terraform automation usage.

If you already have created one, or other team is in charge and has created it, use that and skip this step; otherwise create one yourself following the steps below:

```
az login
az account list
#Get your subscription ID from above output, and put it in the following two commands.
az account set --subscription="SUBSCRIPTION_ID"
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"
```

The last command will output 5 values, of which:

- appId is the client_id defined above.
- password is the client_secret defined above.
- tenant is the tenant_id defined above.

Finally, it's possible to test these values work as expected by first logging in:

```
az login --service-principal -u CLIENT_ID -p CLIENT_SECRET --tenant TENANT_ID
az vm list-sizes --location westus
```

### Create Terraform Config

We use modules and separate folders for different environments for terraform. For example, folder `prod` contains tf files for production env, and `dev` folder contains files for development env, while folder `modules` holds all the commonly shared tf code.

If everything works in the previous step, rename `config.tf.template` to `<env>/config.tf` (for example, `dev/config.tf` or `prod/config.tf`) and update the values accordingly.

For more details about creating service pricipal, see [official document](https://www.terraform.io/docs/providers/azurerm/authenticating_via_service_principal.html).

### Create Service Principal for Databricks

We need another pricipal for Databricks:

If you already have created one, or other team is in charge and has created it, use that and skip this step; otherwise create one yourself following the steps below:

`az ad sp create-for-rbac --name="{{ databricks_app_name }}" --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"`

**Note**: the `databricks_app_name` should be the same as in `cfg.ini` file, which is mentioned in latter steps.

### Manual Steps for Databricks cluster generation

After infrastructure is automatically deployed, only databricks workspace is created, not the cluster. For automatic cluster creation, see [here](./helpers/README.md).
