
# Create server pods and testpods 
kubectl apply -f "C:\github\Spike-on-Network-policy-in-K8s\Linux only cluster using azure npm\Case-11-Allow-egress-to-some-pods-in-a-namespace\Serverpods.yaml"
kubectl apply -f "C:\github\Spike-on-Network-policy-in-K8s\Linux only cluster using azure npm\Case-11-Allow-egress-to-some-pods-in-a-namespace\Testpods.yaml"
kubectl get pods -n development --show-labels
kubectl get pods --show-labels
# Apply the network policy file 
kubectl apply -f "C:\github\Spike-on-Network-policy-in-K8s\Linux only cluster using azure npm\Case-11-Allow-egress-to-some-pods-in-a-namespace\Networkpolicy.yaml"

# Shouldn't be allowed
kubectl exec -n development lin-frontend-testpod -- nc -vz $(kubectl get pod linux-backend-pod -n development -o 'jsonpath={.status.podIP}') 80
kubectl exec -n development lin-frontend-testpod -- nc -vz $(kubectl get pod linux-webserver-pod -o 'jsonpath={.status.podIP}') 80

# Should be allowed
kubectl exec -n development lin-frontend-testpod -- nc -vz $(kubectl get pod linux-default-backend-pod -o 'jsonpath={.status.podIP}') 80

# Clean up
kubectl delete pod lin-frontend-testpod -n development
kubectl delete pod linux-webserver-pod 
kubectl delete pod linux-backend-pod -n development
kubectl delete pod linux-default-backend-pod
kubectl delete netpol limit-egress-to-pods-in-a-namespace -n development

