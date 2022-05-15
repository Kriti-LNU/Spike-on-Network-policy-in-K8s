
# CASE 3 DENY ALL INGRESS TO A NAMESPACE 

# Create an nginx pod in default namespace 
kubectl run webapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine --expose --port 80

# Create another pod and attach a terminal session to test that you can successfully reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod 

# Use wget to confirm if you can access the default NGINX webpage:
wget -O- --timeout=2 --tries=1 http://webapp
# The pod will be reachable as no networkpolicy has been applied yet 
# exit the testpod session(it will be deleted automatically)
exit

# Define the yaml file for network policy 
# Case-3-deny-all-ingress-to-namespace.yaml is defined 

# Apply the yaml file 
kubectl apply -f "C:\github\Network policies in K8s\Case-3-deny-all-ingress-to-namespace.yaml"

# Again try accessing the webapp pod using testpod 
# Create another pod and attach a terminal session to test that the reachability of the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod 
# Use wget to confirm if you can access the default NGINX webpage:
wget -O- --timeout=2 --tries=1 http://webapp
# The pod will not be reachable as the applied networkpolicy blocks all incoming traffic 
# exit the testpod session(it will be deleted automatically)
exit

# CleanUp
kubectl delete pod,svc webapp
kubectl delete networkpolicy deny-all-ingress-to-namespace