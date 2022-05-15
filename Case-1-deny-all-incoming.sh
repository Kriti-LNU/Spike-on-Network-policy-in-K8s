
# CASE 1 DENY ALL INCOMING TRAFFIC TO AN APPLICATION

# Create an nginx pod webapp with app=backend open on port 80
kubectl run webapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine --labels "app=backend" --expose --port 80

# Create another pod and attach a terminal session to test that you can successfully reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod 

# Use wget to confirm that you can access the default NGINX webpage:
wget -O- --timeout=2 --tries=1 http://webapp
# The pod will be reachable 
# exit the testpod session(it will be deleted automatically)
exit

# Define the yaml file for network policy 
# Case-1-deny-all-incoming-to-webapp.yaml is defined 

# Apply the yaml file 
kubectl apply -f "C:\github\Network policies in K8s\Case-1-deny-all-incoming-to-webapp.yaml"

# Again try accessing the webapp pod using testpod 
# Create another pod and attach a terminal session to test that the reachability of the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod 
# Use wget to confirm if you can access the default NGINX webpage:
wget -O- --timeout=2 --tries=1 http://webapp
# The pod will not be reachable 

# CleanUp
kubectl delete pod,svc webapp
kubectl delete networkpolicy deny-all-incoming-to-webapp