#!/bin/bash

export app_name=amp-endava

export KUBECONFIG=./config/kube-config

# Install the amp stack with helm

echo -e "\nInstalling the amp stack with helm..."

helm install --name $app_name -f config/amp-helm-params.yaml stable/lamp
result=$?
(( result )) && { echo -e "\nHelm failed with $result.\nTry setting a new app_name in the init.sh script.\n\n" ; exit $result ; }

echo -e "\nPlease wait for init to complete! No more than 30 minutes, I promise..."

# Waiting for half an hour is enough
typeset -i max_time=1800		# 30min x 60sec
typeset -i elapsed=0
typeset -i interval=10

while :
do
	sleep $interval
	(( elapsed+=interval ))
	echo -n "$elapsed..."

	export CHARTIP=$(kubectl get svc ${app_name}-lamp --output=jsonpath={.status.loadBalancer.ingress..ip})
	[[ -z $CHARTIP ]] || break
	(( elapsed > max_time )) && { echo -e "\n\nSomething is wrong. Can't wait any more." ; exit 1 ; }
done

# Upload initial web content
./upload.sh

echo -e "\nFinished isntallation!!!"
echo -e "\nOpen http://$CHARTIP in the browser :-)\n\n"
