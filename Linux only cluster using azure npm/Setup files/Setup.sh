
RESOURCE_GROUP_NAME="Linux-only-NP"
CLUSTER_NAME="LinOnlyCluster"
LOCATION="eastus"

# Create a resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create a virtual network and subnet
az network vnet create \
    --resource-group $RESOURCE_GROUP_NAME \
    --name Vnet \
    --address-prefixes 10.0.0.0/8 \
    --subnet-name AKSSubnet \
    --subnet-prefix 10.240.0.0/16

# Get the subnet resource ID for the existing subnet into which the AKS cluster will be joined:
SUBNET_ID=$(az network vnet subnet list \
     --resource-group $RESOURCE_GROUP_NAME \
    --vnet-name Vnet \
    --query "[0].id" --output tsv)

DNS_SERVICE_IP="10.0.10.10"
SERVICE_CIDR="10.0.10.0/24"
az aks create \
    --resource-group $RESOURCE_GROUP_NAME \
    --name $CLUSTER_NAME \
    --no-ssh-key \
    --enable-managed-identity \
    --network-plugin azure \
    --vnet-subnet-id ${SUBNET_ID} \
    --dns-service-ip ${DNS_SERVICE_IP} \
    --service-cidr ${SERVICE_CIDR} \
    --node-count 1

kubectl apply -f "C:\github\Spike-on-Network-policy-in-K8s\Linux only cluster using azure npm\Setup files\azure-npm.yaml"