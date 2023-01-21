#!/bin/bash

# Push the Docker image that you just built to the repository
docker push ${LOCATION}-docker.pkg.dev/${PROJECT_ID}/docker-flask-locust-gcp/sample-webapp:${SHORT_SHA}
