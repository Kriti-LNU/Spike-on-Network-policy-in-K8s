
# CASE 11 ALLOW ALL INCOMING TRAFFIC FROM SELECTED PODS IN A NAMESPACE

# Create development namespace 
kubectl create namespace development
kubectl label namespace/development purpose=development

# Create an nginx pod webapp with label app=web in default namespace open on port 80
kubectl run webapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine --labels "app=web" --expose --port 80

# Define the yaml file for network policy 
# Case-12-allow-traffic-from-some-pods-in-a-namespace.yaml defined

# Apply the yaml file 
kubectl apply -f "C:\github\Network policies in K8s\Case-12-allow-traffic-from-some-pods-in-a-namespace.yaml"

# Try accessing the webapp pod using testpod with app=api in development namespace
# Create another pod try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --labels "app=api" --namespace development
# Use wget to confirm  if you can access the default NGINX webpage:
wget -qO- http://webapp.default 
# The pod will be reachable as we allowed all incoming connections from pods with app:api in development namespace 
# exit the testpod session(it will be deleted automatically)
exit

# Try accessing the webapp pod using testpod with app=anyLabel in development namespace
# Create another pod try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --labels "app=anyLabel" --namespace development
# Use wget to confirm  if you can access the default NGINX webpage:
wget -O- --timeout=2 --tries=1 http://webapp.default 
# The pod will not be reachable as we allowed all incoming connections from pods with app:api in development namespace 
# exit the testpod session(it will be deleted automatically)
exit

# CleanUp
kubectl delete pod webapp
kubectl delete svc webapp
kubectl delete networkpolicy allow-traffic-from-selected-pods-in-a-namespace