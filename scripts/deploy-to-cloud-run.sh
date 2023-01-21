#!/bin/bash

gcloud run deploy sample-webapp-${SHORT_SHA} \
	--image=${LOCATION}-docker.pkg.dev/${PROJECT_ID}/docker-flask-locust-gcp/sample-webapp:${SHORT_SHA} \
	--region ${LOCATION} \
	--platform managed \
	--allow-unauthenticated
