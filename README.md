# AMP-STACK

This repo shows a sample implementation of the L/AMP stack using Helm on a Kubernetes cluster on the Google Cloud Platform.

## Specifics

The application uses the `stable/lamp` helm [chart](https://github.com/helm/charts/tree/master/stable/lamp) with some [settings](config/amp-helm-params.yaml) on top.
The stack runs each service from separate containers in the pod. It uses the official images and the ones currently used are:

 - httpd:2.4.29-alpine
 - php:7-fpm
 - mysql:5.7

Communication between the three services is realized over unix sockets.

## A running instance

I have used this repository to create a demo of a running amp stack. It is exposed here http://35.204.68.180/

To see how I did this or to create your own, follow the instructions below.

## Prerequisites

You need to have [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/), [Google Cloud SDK](https://cloud.google.com/sdk/install)  (for `gcloud`) and [Helm](https://docs.helm.sh/using_helm/#installing-helm) installed and setup locally.
> This part cannot be automated as the steps vary per environment/OS

### The Cluster

To avoid mangling your own `~/.kube/config`, the scripts use the kubectl config from [config/kube-config](config/kube-config). It has the context setup for my personal cluster. You will need to provide a cluster and authenticate to it (using `gcloud`), and replace this file before you continue onwards.

## Setup Helm

Once you have the `helm` client installed locally, run the following command to install Tiller on the cluster:

```console
$ ./setup-helm.sh
```

## Install the AMP stack

```console
$ ./init.sh
```

This will use helm to install the amp stack with our settings. It will also populate the web server with the initial contents from the `html` folder, which is just a *Hello* page.

When it is done it will display a URL for our working web site.

You can modify the scripts/files/html and create the stack again. Before executing the `init.sh`, you need to delete the old stack:

```console
helm delete amp-endava --purge
```

Or you can modify the `app_name` variable in `init.sh` to create a new stack.

## Updating the web content

To update the web site, add more files inside `html` and just run:

```console
$ ./upload.sh
```