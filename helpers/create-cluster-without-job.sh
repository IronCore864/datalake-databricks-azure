#!/bin/bash

token=<replace-with-your-token>

clusterid=$(curl -s 'https://westeurope.azuredatabricks.net/api/2.0/clusters/create' -X POST -H "Authorization: Bearer $token" -H "Content-type: application/json" -d @create-databricks-cluster-without-job-payload.json | jq -r .cluster_id)

echo "New cluster created, ID is: $clusterid".

