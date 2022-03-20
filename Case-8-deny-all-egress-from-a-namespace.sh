
# CASE 8 DENY ALL EGRESS TRAFFIC FROM A NAMESPACE 

# Create a new namespace production with label purpose=production
kubectl create namespace production
kubectl label namespace/production purpose=production

# Create an nginx pod webapp open on port 80 in production namespace 
kubectl run webapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine  --expose --port 80 --namespace production

# Try accessing the webapp pod using testpod in production namespace 
# Create another pod try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --namespace production
# Use wget to confirm if you can access the default NGINX webpage:
wget -O- --timeout=2 --tries=1 http://webapp
# The pod will be reachable as no networkpolicy has been applied yet 
# exit the testpod session(it will be deleted automatically)
exit

# Define the yaml file for network policy 
# Case-8-deny-all-egress-from-namespace.yaml defined 

# Apply the yaml file 
kubectl apply -f "C:\github\Network policies in K8s\Case-8-deny-all-egress-from-namespace.yaml"

# Try accessing the webapp pod using testpod in production namespace 
# Create another pod try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --namespace production
# Use wget to confirm if you can access the default NGINX webpage:
wget -O- --timeout=2 --tries=1 http://webapp
# The pod will be not reachable as no egress is allowed from production namespace 
# exit the testpod session(it will be deleted automatically)
exit

# CleanUp
kubectl delete pod,svc webapp --namespace production
kubectl delete networkpolicy deny-all-egress-from-namespace --namespace production