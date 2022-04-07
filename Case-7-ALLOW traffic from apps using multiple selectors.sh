
# CASE 7 ALLOW TRAFFIC FROM MULTIPLE APPLICATIONS 

# Create an nginx pod webapp with label app=backend open on port 80
kubectl run webapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine --labels "web" --expose --port 80

# Define the yaml file for network policy 
# Case-7-ALLOW traffic from apps using multiple selectors.yaml defined

# Apply the yaml file 
kubectl apply -f "C:\github\Spike-on-Network-policy-in-K8s\Case-7-ALLOW traffic from apps using multiple selectors.yaml"

# Try accessing the webapp pod using testpod with label app=inventory or role=contributor or api=apiVersion
# try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --labels="app=inventory"
# Use wget to confirm  if you can access the default NGINX webpage:
wget -O- --timeout=2 --tries=1 http://webapp
# The pod will be reachable 

# Again try accessing the webapp pod using testpod with any label other than the ones allowed or no label
# try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --labels="app=Anylabel"
# Use wget to confirm  if you can access the default NGINX webpage:
wget -O- --timeout=2 --tries=1 http://webapp
# The pod will be not reachable 

# CleanUp
kubectl delete pod,svc webapp
kubectl delete networkpolicy allow-from-multiple-pods