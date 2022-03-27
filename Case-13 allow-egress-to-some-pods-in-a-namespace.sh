
# CASE 13: ALLOW traffic only to some Pods in a namespace

# Create an nginx pod webapp with label app=backend in development namespace open on port 80
kubectl run webapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine --labels "app=backend" --expose --port 80 --namespace development
# Create another nginx pod myapp with label app=api in development namespace open on port 80
kubectl run myapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine --labels "app=api" --expose --port 80 --namespace development
# Define the yaml file for network policy 
# Case-13-allow-egress-to-some-pods-in-a-namespace.yaml defined

# Apply the yaml file 
kubectl apply -f "C:\github\Spike-on-Network-policy-in-K8s\Case-13-allow-egress-to-some-pods-in-a-namespace.yaml"

# Try accessing the webapp pod using testpod with label app=frontend in production namespace 
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --labels="app=frontend" --namespace production
# Use wget to confirm  if you can access the NGINX webapp:
wget -O- --timeout=2 --tries=1 http://webapp.development
# The pod will be reachable as we allowed egress connections to pods with label app=backend in development namespace 

# Use wget to confirm if you can access myapp pod with app:api
wget -O- --timeout=2 --tries=1 http://myapp.development
# The pod will not be reachable as we allowed egress connections only to pods with label app=backend
# exit the testpod session(it will be deleted automatically)
exit

# CleanUp
kubectl delete pod,svc webapp --namespace development
kubectl delete pod,svc myapp --namespace development
kubectl delete networkpolicy allow-egress-from-some-pods-in-a-namespace