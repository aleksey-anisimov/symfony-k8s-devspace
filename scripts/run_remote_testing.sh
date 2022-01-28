#!/bin/bash

# Disable exit on non 0
set +e
devspace purge --profile=testing --kube-context=testing --namespace="${CI_COMMIT_SHA}"
# Enable exit on non 0
set -e

devspace deploy --profile=testing --kube-context=testing --no-warn --namespace="${CI_COMMIT_SHA}"

while [[ $(kubectl get pods --context=testing --namespace="${CI_COMMIT_SHA}" -l io.kompose.service=symfony-k8s-postgresql -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for postgresql pod" && sleep 1; done
while [[ $(kubectl get pods --context=testing --namespace="${CI_COMMIT_SHA}" -l io.kompose.service=symfony-k8s-web -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for web pod" && sleep 1; done

devspace enter --profile=testing --kube-context=testing --namespace="${CI_COMMIT_SHA}" --container=symfony-k8s-php --wait make tests
devspace purge --profile=testing --kube-context=testing --namespace="${CI_COMMIT_SHA}"