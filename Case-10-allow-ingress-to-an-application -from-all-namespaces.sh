
# CASE 10 ALLOW ALL INCOMING TRAFFIC TO AN APPLICATION FROM ALL NAMESPACES 

# Create an nginx pod webapp with label app=backend in default namespace open on port 80
kubectl run webapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine --labels "app=web" --expose --port 80

# Define the yaml file for network policy 
# Case-10-allow-traffic-to-an-application-from-all-namespaces.yaml defined

# Apply the yaml file to allow traffic from all namespaces 
kubectl apply -f "C:\github\Network policies in K8s\Case-10-allow-traffic-to-an-application-from-all-namespaces.yaml"


# Try accessing the webapp pod using testpod in default namespace 
# Create another pod try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod 
# Use wget to confirm  if you can access the default NGINX webpage:
wget -qO- http://webapp 
# The pod will be reachable as we allowed all incoming connections from all namespaces
# exit the testpod session(it will be deleted automatically)
exit

# Try accessing the webapp pod using testpod in production namespace 
# Create another pod try to reach the default NGINX webpage:
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --namespace production
# Use wget to confirm  if you can access the default NGINX webpage:
wget -qO- http://webapp.default 
# The pod will be reachable as we allowed all incoming connections from all namespaces
# exit the testpod session(it will be deleted automatically)
exit

# CleanUp
kubectl delete pod webapp
kubectl delete svc webapp
kubectl delete networkpolicy allow-ingress-from-all-namespaces 
kubectl delete networkpolicy deny-all-ingress-to-namespace
