#!/bin/bash

token=<replace-with-your-token>

clusterid=$(curl -s 'https://westeurope.azuredatabricks.net/api/2.0/jobs/create' -X POST -H "Authorization: Bearer $token" -H "Content-type: application/json" -d @create-job-payload.json | jq -r .job_id)

echo "New job created with a new cluster, ID is: $clusterid".

