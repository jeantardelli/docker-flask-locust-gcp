#!/bin/bash

export LOCATION=europe-west1
export PROXY_VM=locust-nginx-proxy
export INTERNAL_LB_IP=$(kubectl get svc locust-master-web  \
                               -o jsonpath="{.status.loadBalancer.ingress[0].ip}") && \
                               echo $INTERNAL_LB_IP
