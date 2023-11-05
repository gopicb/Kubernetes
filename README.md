# Kubernetes
RBAC Certificate Creation script

1. Add the required details in shell script
2. excute the script and it will create the CSR and CRT and Key file in the current direcorty
3. copy the kubeconfig file from admin ~/.kube/config file
4. modify the create user details in config file and remove the already created user list ( Example - remove admin users )
5. check the file permission of certifications
6. create the Role and role binding or cluster role binding
7. share the certification and and config files to user and install kubectl in users machines 
