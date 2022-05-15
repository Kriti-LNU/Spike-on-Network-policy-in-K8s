# Network policy for using named ports instead of hard-coded port numbers

# Create an application that returns nginx response on port 80 and hello response on port 8080
# name port 80 to http-web-svc and 8080 to hello-node
# Expose the pod as Service, map 80 to 8001, map 8080 to 5001.
kubectl apply -f "C:\github\Spike-on-Network-policy-in-K8s\Case-14-NP-using-named-ports-deployment.yaml"

# Before applying the networkpolicy file try reaching the pod from the ports from pod with label run=curl
# Observe traffic to both the ports - 80(http-web-svc) and 8080(hello-node) is allowed
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --labels="run=curl"
curl http://sample-service:8001
curl http://sample-service:5001


# Apply the network policy file
kubectl apply -f "C:\github\Spike-on-Network-policy-in-K8s\Case-14-NP-using-named-ports-NP.yaml"

# Now try reaching the pod from two ports 
# Observe traffic is allowed only to the port - 80(http-web-svc) 
kubectl run --rm -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11 testpod --labels="run=curl"
curl http://sample-service:8001
curl http://sample-service:5001