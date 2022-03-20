
# CASE 3 ALLOW ALL INCOMING TRAFFIC TO AN APPLICATION

# Create an nginx pod webapp with label app=backend open on port 80
kubectl run webapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine --labels "app=backend" --expose --port 80

# Define the yaml file for network policy 
# Case-3-allow-all-incoming-to-webapp.yaml defined

# Apply the yaml file 
kubectl apply -f "C:\github\Network policies in K8s\Case-3-allow-all-incoming-to-webapp.yaml"

# Try accessing the webapp pod using testpod
# Create another pod try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod 
# Use wget to confirm  if you can access the default NGINX webpage:
wget -qO- http://webapp 
# The pod will be reachable as we allowed all incoming connections from all pods in the default namespace 
# exit the testpod session(it will be deleted automatically)
exit

# CleanUp
kubectl delete pod webapp
kubectl delete svc webapp
kubectl delete networkpolicy allow-all-incoming-to-webapp