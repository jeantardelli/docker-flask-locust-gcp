set -e

gcloud compute instances create-with-container ${PROXY_VM}    \
     --zone ${LOCATION}-d \
     --container-image gcr.io/cloud-marketplace/google/nginx1:latest \
     --container-mount-host-path=host-path=/tmp/server.conf,mount-path=/etc/nginx/conf.d/default.conf \
     --metadata=startup-script="#! /bin/bash
       cat <<EOF > /tmp/server.conf
       server {
           listen 8089;
           location / {
               proxy_pass http://${INTERNAL_LB_IP}:8089;
           }
       }
EOF"

echo "To open an SSH tunnel between your workstation and this proxy instance, use this command:"
echo "  gcloud compute ssh --zone ${LOCATION} ${PROXY_VM} -- -N -L 8089:localhost:8089"
