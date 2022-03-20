
# CASE 9 DENY ALL INGRESS FROM OTHER NAMESPACES 

# Create an nginx pod in default namespace 
kubectl run webapp --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine  --labels="app=web" --expose --port 80

# Define the yaml file for network policy 
# Case-9-deny-traffic-from-other-namespaces.yaml is defined 

# Apply the yaml file 
kubectl apply -f "C:\github\Network policies in K8s\Case-9-deny-traffic-from-other-namespaces.yaml"

# Try accessing the webapp pod using testpod in default namespace 
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod 
# Use wget to confirm if you can access the default NGINX webpage:
wget -O- --timeout=2 --tries=1 http://webapp
# The pod will be reachable as the applied networkpolicy allows all incoming traffic from same namespace
# exit the testpod session(it will be deleted automatically)
exit

# Try accessing the webapp pod using testpod in production namespace 
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --namespace production
# Use wget to confirm if you can access the default NGINX webpage:
wget -O- --timeout=2 --tries=1 http://webapp.default 
# The pod will be not reachable as the applied networkpolicy allows all incoming traffic only from same namespace
# exit the testpod session(it will be deleted automatically)
exit

# CleanUp
kubectl delete pod,svc webapp
kubectl delete networkpolicy deny-from-other-namespaces