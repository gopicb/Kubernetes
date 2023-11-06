# Kubernetes
RBAC Certificate Creation script

1. Add the required details in shell script
2. Add the API server details to connect the server in bottom of the script 
3. excute the script and it will create the CSR and CRT and Key file and kubeconfig in the current direcorty
4. check the user details in config file and remove the already created user list ( Example - remove admin users )
5. check the file permission of certifications
6. create the Role and role binding or cluster role binding
7. sudo kubectl apply -f role or rolebinding.yaml 
8. share the certification and and config files to user and install kubectl in users machines 
   
