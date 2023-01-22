#!/bin/bash

export TARGET_APP=$(gcloud run services list --format 'value(status.url)')

envsubst < kubernetes-config/locust-master-controller.yaml.tpl | kubectl apply -f -
envsubst < kubernetes-config/locust-worker-controller.yaml.tpl | kubectl apply -f -
envsubst < kubernetes-config/locust-master-service.yaml.tpl | kubectl apply -f -
