
# CASE 2 LIMIT INCOMING TRAFFIC TO AN APPLICATION

# Create an nginx pod webapp with label app=backend open on port 80
kubectl run webapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine --labels "app=backend" --expose --port 80

# Define the yaml file for network policy 
# Case-2-Limit-traffic-to-webapp.yaml defined

# Apply the yaml file 
kubectl apply -f "C:\github\Network policies in K8s\Case-2-Limit-traffic-to-webapp.yaml"

# Try accessing the webapp pod using testpod with label app=frontend
# Create another pod with label app=frontend and try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --labels="app=frontend"
# Use wget to confirm  if you can access the default NGINX webpage:
wget -O- --timeout=2 --tries=1 http://webapp
# The pod will be reachable as we allowed incoming connections from pods with label app=frontend

# Again try accessing the webapp pod using testpod with any label other than app:frontend or no label
# Create another pod with label app=Anyapp and try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --labels="app=Anyapp"
# Use wget to confirm  if you can access the default NGINX webpage:
wget -O- --timeout=2 --tries=1 http://webapp
# The pod will not be reachable as we allowed incoming connections only from pods with label app=frontend

# CleanUp
kubectl delete pod,svc webapp
kubectl delete networkpolicy limit-incoming-to-webapp