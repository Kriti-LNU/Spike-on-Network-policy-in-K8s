

# Create an nginx pod webapp open on port 80 
kubectl run webapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine  --expose --port 80  

# Define the yaml file for network policy 
# Subnets-and-ip-addresses.yaml

# Apply the yaml file 
kubectl apply -f "C:\github\Spike-on-Network-policy-in-K8s\Subnets-and-ip-addresses.yaml"
# Try accessing the webapp pod using testpod 
# Create another pod try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod
# Use wget to confirm if you can access the default NGINX webpage:
wget -qO- http://webapp
# The pod will not be reachable 
# try accessing the allowed ip
wget -O- --timeout=2 http://8.8.8.8
# rechable 


# CleanUp
kubectl delete pod,svc webapp 
kubectl delete networkpolicy egress-dns
