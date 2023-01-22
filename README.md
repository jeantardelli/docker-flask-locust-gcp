# docker-flask-locust-gcp

A docker + flask + locust on GCP demo project. Exercise from the Cloud Computing for Data Analysis

The following description was adapted from [Distributed load testing using Google Kubernetes Engine tutorial](https://cloud.google.com/architecture/distributed-load-testing-using-gke). [This](https://github.com/GoogleCloudPlatform/distributed-load-testing-using-kubernetes) is the tutorial official sample.

This repo is the result of the [this tutorial](https://cloud.google.com/architecture/distributed-load-testing-using-gke) that explains how to use Google Kubernetes Engine (GKE) to deploy a distributed load testing framework that uses multiple containers to create traffic for a simple REST-based API. I just changed a bit the tutorial for the load-tests be applied to a web application deployed to a Cloud Run instance that exposes REST-style endpoints to respond to incoming HTTP POST request.

You can use this same pattern to create load testing frameworks for a variety of scenarios and applications, such as messaging systems, data stream management systems, and database systems.

## Workload Example

![image](https://user-images.githubusercontent.com/42701946/213944952-e628a419-b184-4494-aef5-312882d02a06.png)

To model this interaction, you can use Locust, a distributed, Python-based load testing tool that can distribute requests across multiple target paths.

## Archictecture

This architecture involves two main components:

- The Locust Docker container image.
- The container orchestration and management mechanism.

The Locust Docker container image contains the Locust software. The Dockerfile, which you get when you clone this repo, that accompanies this tutorial, uses a base Python image and includes scripts to start the Locust service and execute the tasks.

GKE provides container orchestration and management. With GKE, you can specify the number of container nodes that provide the foundation for your load testing framework. You can also organize your load testing workers into Pods, and specify how many Pods you want GKE to keep running.

To deploy the load testing tasks, you do the following:

- Deploy a load testing master.
- Deploy a group of load testing workers. With these load testing workers, you can create a substantial amount of traffic for testing purposes.

The following diagram shows the architecture that demonstrates load testing using a sample application:

![image](https://user-images.githubusercontent.com/42701946/213945252-712fb0c5-36d5-4f3f-85a1-000d51ea0321.png)

## Run the locust master

After the build is complete, start the GKE services: `source ./scripts/deploy-locust-master-and-worker-pods.sh` and then:

1. Set an environment variable with the name of the instance: `export PROXY_VM=locust-nginx-proxy`
2. Set location environment variable: e.g. `export LOCATION=europe-west1`
3. Get the internal ip address:
```bash
export INTERNAL_LB_IP=$(kubectl get svc locust-master-web  \
                               -o jsonpath="{.status.loadBalancer.ingress[0].ip}") && \
                               echo $INTERNAL_LB_IP
```
4. Start an instance with a ngnix docker container configured to proxy the Locust web application port 8089 on the Internal TCP/UDP Load Balancing:

```bash
gcloud compute instances create-with-container ${PROXY_VM} \
   --zone ${LOCATION} \
   --container-image gcr.io/cloud-marketplace/google/nginx1:latest \
   --container-mount-host-path=host-path=/tmp/server.conf,mount-path=/etc/nginx/conf.d/default.conf \
   --metadata=startup-script="#! /bin/bash
     cat <<EOF  > /tmp/server.conf
     server {
         listen 8089;
         location / {
             proxy_pass http://${INTERNAL_LB_IP}:8089;
         }
     }
EOF"
```
