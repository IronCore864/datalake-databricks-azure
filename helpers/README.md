# Databricks Cluster Creation Automation

## Prerequisites

- Databricks workspace is already created (done by the parent folder of this repo).
- `jq` is installed.

For Mac users, install `jq` with brew:

```
brew install jq
```

## Generate a Token

The very first token in a databricks workspace must be created manually, because at that time there isn't a token available for API calls yet.

Steps:

- Login to Azure, open your databricks workspace
- Click the user profile icon User Profile in the upper right corner of your Azure Databricks workspace.
- Click User Settings and go to the Access Tokens tab.
- Click the Generate New Token button, optionally enter a description (comment) and expiration period, then click the Generate button.
- Copy the generated token and replace the content of "<replace-with-your-token>" in `*.sh` files.

## Update Parameters

Open file `*.json` and update the parameters accordingly.

## Run

```
# This will create a new cluster without a job
./create-cluster-without-job.sh
# or the following will create a job in a new cluster
./create-job-with-new-cluster.sh
```

and get cluster ID in the STDOUT.

