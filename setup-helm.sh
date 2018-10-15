#!/bin/bash

export KUBECONFIG=.config/kube-config

# Setup helm's tiller with k8s on Google Cloud

echo -n "Creating a service account for tiller..."
kubectl --namespace kube-system create serviceaccount tiller

echo -n "Creating a role binding for the tiller account..."
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
#kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

echo -n "Installing tiller on the cluster..."
helm init --service-account tiller

echo -n "Finished setting helm with tiller!!!"
