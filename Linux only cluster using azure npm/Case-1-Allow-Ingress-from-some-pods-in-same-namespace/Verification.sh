
# Setup pods and Np for verification
kubectl create namespace development
kubectl label namespace/development purpose=development
kubectl apply -f "C:\github\Spike-on-Network-policy-in-K8s\Linux only cluster using azure npm\Case-1-Allow-Ingress-from-some-pods-in-same-namespace\Serverpods.yaml"
kubectl apply -f "C:\github\Spike-on-Network-policy-in-K8s\Linux only cluster using azure npm\Case-1-Allow-Ingress-from-some-pods-in-same-namespace\Testpods.yaml"
kubectl get pods -n development --show-labels 

# Apply NP
kubectl apply -f "C:\github\Spike-on-Network-policy-in-K8s\Linux only cluster using azure npm\Case-1-Allow-Ingress-from-some-pods-in-same-namespace\Networkpolicy.yaml"

# After applying NP
# Should be reachable
kubectl exec --namespace development lin-frontend-testpod -- nc -vz $(kubectl get pod linux-backend-pod --namespace development -o 'jsonpath={.status.podIP}') 80

# Should not be reachable
kubectl exec --namespace development lin-apiserver-testpod -- nc -vz $(kubectl get pod linux-backend-pod  --namespace development -o 'jsonpath={.status.podIP}') 80
kubectl exec lin-frontend-default-testpod -- nc -vz $(kubectl get pod linux-backend-pod --namespace development -o 'jsonpath={.status.podIP}') 80

# CleanUp

kubectl delete pod lin-apiserver-testpod -n development
kubectl delete pod linux-backend-pod -n development
kubectl delete pod lin-frontend-testpod -n development
kubectl delete pod lin-frontend-default-testpod 
kubectl delete netpol limit-ingress-using-podselector -n development