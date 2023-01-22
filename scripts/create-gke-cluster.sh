#!/bin/bash

export RESULT=$(gcloud container clusters describe docker-flask-locust-gcp-cluster --region ${LOCATION}-d --format json)

if [ -z "$RESULT" ]
then
  gcloud container clusters create docker-flask-locust-gcp-cluster \
	  --region ${LOCATION}-d \
	  --enable-autoscaling \
	  --num-nodes 2 \
	  --min-nodes 3 \
	  --max-nodes 10 \
	  --scopes "https://www.googleapis.com/auth/cloud-platform"
else
  echo "Cluster already exists!"
fi
