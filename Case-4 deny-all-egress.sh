
# CASE 4 DENY ALL EGRESS TRAFFIC FROM AN APPLICATION

# Create an nginx pod webapp open on port 80
kubectl run webapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine  --expose --port 80

# Define the yaml file for network policy 
# Case-4-deny-all-egress.yaml defined 

# Apply the yaml file 
kubectl apply -f "C:\github\Network policies in K8s\Case-4-deny-all-egress.yaml"

# Try accessing the webapp pod using testpod with app: backend 
# Create another pod try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --labels "app=backend"
# Use wget to confirm if you can access the default NGINX webpage:
wget -O- --timeout=2 --tries=1 http://webapp
# The pod will be not reachable as no egress is allowed from pods with "app:backend"
# exit the testpod session(it will be deleted automatically)
exit


# CleanUp
kubectl delete pod webapp
kubectl delete svc webapp
kubectl delete networkpolicy deny-all-egress