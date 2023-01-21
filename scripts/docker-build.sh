#!/bin/bash

docker build -t ${LOCATION}-docker.pkg.dev/${PROJECT_ID}/docker-flask-locust-gcp/sample-webapp:${SHORT_SHA} ./sample-webapp/.
ls
