#!/bin/bash


RESULT=`gcloud artifacts repositories describe docker-flask-locust-gcp --location=${LOCATION} --format="json"`
if [ -z "$RESULT" ]
then
  echo "The error above means there is no Artifact Repository. Let's create one!"
  gcloud config get-value project
  # Create the Artifact Registry repo
  gcloud artifacts repositories create docker-flask-locust-gcp \
    --project=${PROJECT_ID} \
    --repository-format=docker \
    --location=${LOCATION} \
    --description="Docker repository"
else
  echo "Artifact Registry already exists!"
fi
