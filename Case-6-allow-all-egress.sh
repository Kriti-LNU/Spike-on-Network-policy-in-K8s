
# CASE 6 ALLOW ALL EGRESS FROM AN APPLICATION

# Create an nginx pod webapp open on port 80 in development namespace 
kubectl run webapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine  --expose --port 80  --namespace development 

# Define the yaml file for network policy 
# Case-6-allow-all-egress.yaml

# Apply the yaml file 
kubectl apply -f "C:\github\Spike-on-Network-policy-in-K8s\Case-6-allow-all-egress.yaml"
# Try accessing the webapp pod using testpod from default namespace
# Create another pod try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod
# Use wget to confirm if you can access the default NGINX webpage:
wget -qO- http://webapp.development
# The pod will be reachable as egress to all namespaces is allowed from pods in default namespace
# try accessing external hostnames using testpod
wget -O- --timeout=2 http://www.google.com
# the site is not reachable since external communications are not allowed.


# CleanUp
kubectl delete pod,svc webapp --namespace development
kubectl delete networkpolicy allow-all-egress