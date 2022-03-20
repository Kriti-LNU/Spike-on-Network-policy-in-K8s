
# CASE 6 ALLOW ALL EGRESS FROM AN APPLICATION

# Create an nginx pod webapp open on port 80
kubectl run webapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine  --expose --port 80

# Define the yaml file for network policy 
# allow-all-egress.yaml defined 

# Apply the yaml file 
kubectl apply -f allow-all-egress.yaml

# Try accessing the webapp pod using testpod with app: backend 
# Create another pod try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --labels "app=backend"
# Use wget to confirm if you can access the default NGINX webpage:
wget -qO- http://webapp
# The pod will be reachable as all egress is allowed from pods with "app:backend"

# CleanUp
kubectl delete pod webapp
kubectl delete svc webapp
kubectl delete networkpolicy allow-all-egress