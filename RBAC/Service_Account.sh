#!/bin/bash

CLUSTERNAME=kubernetes
NAMESPACE=default
SERVICE_ACCOUNT_NAME=cicd-service-account
KUBECONFIG_FILENAME=kubeconfig_cicd

# Create a service account
kubectl create serviceaccount $SERVICE_ACCOUNT_NAME -n $NAMESPACE

# Get the service account token
SECRET_NAME=$(kubectl get serviceaccount $SERVICE_ACCOUNT_NAME -n $NAMESPACE -o jsonpath='{.secrets[0].name}')
SERVICE_ACCOUNT_TOKEN=$(kubectl get secret $SECRET_NAME -n $NAMESPACE -o jsonpath='{.data.token}' | base64 -d)

# Create a kubeconfig file
kubectl config set-credentials $SERVICE_ACCOUNT_NAME --token=$SERVICE_ACCOUNT_TOKEN
kubectl config set-cluster $CLUSTERNAME --server=https://10.0.10.251:6443
kubectl config set-context $SERVICE_ACCOUNT_NAME-context --cluster=$CLUSTERNAME --namespace=$NAMESPACE --user=$SERVICE_ACCOUNT_NAME
kubectl config use-context $SERVICE_ACCOUNT_NAME-context
kubectl config view --minify --flatten > $KUBECONFIG_FILENAME

echo "Kubeconfig file created: $KUBECONFIG_FILENAME"
