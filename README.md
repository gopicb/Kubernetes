# Kubernetes
RBAC Certificate Creation script

1. Add the required details in shell script
2. excute the script and it will create the CSR and CRT and Key file and kubeconfig in the current direcorty
3. check the user details in config file and remove the already created user list ( Example - remove admin users )
4. check the file permission of certifications
5. create the Role and role binding or cluster role binding
6. sudo kubectl apply -f role or rolebinding.yaml 
7. share the certification and and config files to user and install kubectl in users machines 
   
