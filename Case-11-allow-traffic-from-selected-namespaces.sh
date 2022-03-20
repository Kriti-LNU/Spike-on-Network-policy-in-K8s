
# CASE 11 ALLOW ALL INCOMING TRAFFIC FROM SELECTED NAMESPACES  

# Create development namespace 
kubectl create namespace development
kubectl label namespace/development purpose=development
# Create production namespace 
kubectl create namespace production
kubectl label namespace/production purpose=production
# Create testing namespace 
kubectl create namespace testing
kubectl label namespace/testing purpose=testing

# Create an nginx pod webapp with label app=web in default namespace open on port 80
kubectl run webapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine --labels "app=web" --expose --port 80

# Define the yaml file for network policy 
# Case-11-allow-traffic-from-selected-namespaces.yaml defined

# Apply the yaml file 
kubectl apply -f "C:\github\Network policies in K8s\Case-11-allow-traffic-from-selected-namespaces.yaml"

# Try accessing the webapp pod using testpod in default namespace
# Create another pod try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod 
# Use wget to confirm  if you can access the default NGINX webpage:
wget -qO- http://webapp 
# The pod will be not reachable as we allowed all incoming connections from only production and development namespaces 
# exit the testpod session(it will be deleted automatically)
exit

# Try accessing the webapp pod using testpod in production namespace
# Create another pod try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --namespace production
# Use wget to confirm  if you can access the default NGINX webpage:
wget -qO- http://webapp.default 
# The pod will be reachable as we allowed all incoming connections from only production and development namespaces 
# exit the testpod session(it will be deleted automatically)
exit

# Try accessing the webapp pod using testpod in development namespace
# Create another pod try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --namespace development
# Use wget to confirm  if you can access the default NGINX webpage:
wget -qO- http://webapp.default
# The pod will be reachable as we allowed all incoming connections from only production and development namespaces 
# exit the testpod session(it will be deleted automatically)
exit

# Try accessing the webapp pod using testpod in testing namespace
# Create another pod try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --namespace testing 
# Use wget to confirm  if you can access the default NGINX webpage:
wget -qO- http://webapp.default
# The pod will be not reachable as we allowed all incoming connections from only production and development namespaces 
# exit the testpod session(it will be deleted automatically)
exit

# CleanUp
kubectl delete pod webapp
kubectl delete svc webapp
kubectl delete networkpolicy  allow-traffic-from-selected-namespaces