#!/bin/bash

docker build -t ${LOCATION}-docker.pkg.dev/${PROJECT_ID}/docker-flask-locust-gcp/locust-image:${SHORT_SHA} ./locust-image/.
