
# CASE 5 LIMIT EGRESS TRAFFIC FROM AN APPLICATION

# Create an nginx pod webapp with label app=backend open on port 80
kubectl run webapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine --labels "app=backend" --expose --port 80
# Create another nginx pod myapp with label app=api open on port 80
kubectl run myapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine --labels "app=api" --expose --port 80
# Define the yaml file for network policy 
# Case-5-limit-egress.yaml defined

# Apply the yaml file 
kubectl apply -f "C:\github\Network policies in K8s\Case-5-limit-egress.yaml"

# Try accessing the webapp pod using testpod with label app=frontend
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --labels="app=frontend"
# Use wget to confirm  if you can access the NGINX webapp:
wget -O- --timeout=2 --tries=1 http://webapp
# The pod will be reachable as we allowed egress connections to pods with label app=backend
# exit the testpod session(it will be deleted automatically)
exit

# Use wget to confirm if you can access myapp pod with app:api
wget -O- --timeout=2 --tries=1 http://myapp
# The pod will not be reachable as we allowed egress connections only to pods with label app=backend
# exit the testpod session(it will be deleted automatically)
exit

# CleanUp
kubectl delete pod,svc webapp
kubectl delete pod,svc myapp
kubectl delete networkpolicy limit-egress-from-pod