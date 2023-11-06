#!/bin/bash

CLUSTERNAME=kubernetes
NAMESPACE=default
USERNAME=chetta1
GROUPNAME=mygroup
KUBECONFIG_FILENAME=kubeconfig_${USERNAME}

# Generate a private key for the user
openssl genrsa -out ${USERNAME}.key 2048

CSR_FILE=$USERNAME.csr
KEY_FILE=$USERNAME.key

# Create a CSR
openssl req -new -key $KEY_FILE -out $CSR_FILE -subj "/CN=$USERNAME/O=$GROUPNAME"

CERTIFICATE_NAME=${USERNAME}_CRT

# Create a CertificateSigningRequest and save it to a file
cat <<EOF | kubectl create -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: $CERTIFICATE_NAME
spec:
  request: $(cat $CSR_FILE | base64 | tr -d '\n')
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
EOF

# Approve the CSR
kubectl certificate approve $CERTIFICATE_NAME

CRT_FILE=$USERNAME.crt

# Get the approved certificate and save it to a file
kubectl get csr $CERTIFICATE_NAME -o jsonpath='{.status.certificate}' | base64 -d > $CRT_FILE

# Create a kubeconfig file in the current directory
kubectl config set-credentials $USERNAME \
  --client-certificate=$(pwd)/$CRT_FILE \
  --client-key=$(pwd)/$KEY_FILE
kubectl config set-cluster $CLUSTERNAME --server=https://10.0.10.251:6443
kubectl config set-context $USERNAME-context --cluster=$CLUSTERNAME --namespace=$NAMESPACE --user=$USERNAME
kubectl config use-context $USERNAME-context
kubectl config view --minify --flatten > $KUBECONFIG_FILENAME

echo "Kubeconfig file created: $KUBECONFIG_FILENAME"
