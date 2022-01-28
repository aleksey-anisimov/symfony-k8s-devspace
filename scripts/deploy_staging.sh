#!/bin/bash

devspace deploy --profile=staging --kube-context=staging --namespace=staging --no-warn

while [[ $(kubectl get pods --context=staging --namespace=staging -l io.kompose.service=symfony-k8s-postgresql -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for postgresql pod" && sleep 1; done
while [[ $(kubectl get pods --context=staging --namespace=staging -l io.kompose.service=symfony-k8s-web -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for web pod" && sleep 1; done

devspace enter --profile=staging --kube-context=staging --namespace=staging --container=symfony-k8s-php make staging_post_deploy