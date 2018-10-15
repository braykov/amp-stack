#!/bin/bash

export KUBECONFIG=./config/kube-config

# Install the amp stack with helm

echo -e "\n\nUploading html content...\n"

# Get pod name (we only have one pod)
POD=$(kubectl get pods -o=name)
POD=${POD#pod/}

kubectl -c httpd cp html ${POD}:/var/www

echo -e "\nUpload finished!!!\n"
