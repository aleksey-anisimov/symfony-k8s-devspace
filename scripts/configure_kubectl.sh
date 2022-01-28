#!/bin/bash

docker login -u "${CI_REGISTRY_USER}" -p "${CI_REGISTRY_PASSWORD}" "${CI_REGISTRY}"

# setup test environment
kubectl config set-cluster testing --server="${TESTING_URL}" --insecure-skip-tls-verify=true
kubectl config set-context testing --cluster=testing --namespace=testing --user=testing
kubectl config set-credentials testing
kubectl config set users.testing.client-certificate-data "${TESTING_CLIENT_CRT_DATA}" --set-raw-bytes=false
kubectl config set users.testing.client-key-data "${TESTING_CLIENT_KEY_DATA}" --set-raw-bytes=false

# setup staging
kubectl config set-cluster staging --server="${STAGING_URL}" --insecure-skip-tls-verify=true
kubectl config set-context staging --cluster=staging --namespace=staging --user=staging
kubectl config set-credentials staging
kubectl config set users.staging.client-certificate-data "${STAGING_CLIENT_CRT_DATA}" --set-raw-bytes=false
kubectl config set users.staging.client-key-data "${STAGING_CLIENT_KEY_DATA}" --set-raw-bytes=false
