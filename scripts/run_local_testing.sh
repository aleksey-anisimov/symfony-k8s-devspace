#!/bin/bash

# Disable exit on non 0
set +e
devspace purge --profile=local-testing --kube-context=minikube --namespace=symfony-k8s-testing
# Enable exit on non 0
set -e

devspace deploy --profile=local-testing --kube-context=minikube --namespace=symfony-k8s-testing

while [[ $(kubectl get pods --context=minikube --namespace=symfony-k8s-testing -l io.kompose.service=symfony-k8s-postgresql -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for postgresql pod" && sleep 1; done
while [[ $(kubectl get pods --context=minikube --namespace=symfony-k8s-testing -l io.kompose.service=symfony-k8s-web -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for web pod" && sleep 1; done

devspace enter --profile=local-testing --kube-context=minikube --namespace=symfony-k8s-testing --container=symfony-k8s-php --wait make tests
devspace purge --profile=local-testing --kube-context=minikube --namespace=symfony-k8s-testing