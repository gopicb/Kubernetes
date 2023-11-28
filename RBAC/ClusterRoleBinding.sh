NAMESPACE=default
CLUSTER_ROLE_NAME=cicd-cluster-role
CLUSTER_ROLE_BINDING_NAME=cicd-cluster-role-binding
SERVICE_ACCOUNT_NAME=cicd-service-account

# Create a ClusterRole
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: $CLUSTER_ROLE_NAME
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch", "create", "update", "delete"]
EOF

# Create a ClusterRoleBinding
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: $CLUSTER_ROLE_BINDING_NAME
subjects:
- kind: ServiceAccount
  name: $SERVICE_ACCOUNT_NAME
  namespace: $NAMESPACE
roleRef:
  kind: ClusterRole
  name: $CLUSTER_ROLE_NAME
  apiGroup: rbac.authorization.k8s.io
EOF
