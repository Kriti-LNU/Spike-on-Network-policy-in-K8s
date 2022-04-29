
RESOURCE_GROUP_NAME="ResourceGroup-NP"
CLUSTER_NAME="AKSCluster"
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
    --network-policy azure \
    --vnet-subnet-id ${SUBNET_ID} \
    --dns-service-ip ${DNS_SERVICE_IP} \
    --service-cidr ${SERVICE_CIDR} \
    --node-count 1

#############################################################################################
# Get the subnet resource ID for the existing subnet into which the AKS cluster will be joined:
az network vnet subnet list \
     --resource-group $RESOURCE_GROUP_NAME \
    --vnet-name Vnet \
    --query "[0].id" --output tsv


# Create cluster 
az aks create \
    --resource-group $RESOURCE_GROUP_NAME \
    --name myAKSCluster \
    --network-plugin azure \
    --network-policy azure \
    --vnet-subnet-id <subnet-id>\
    --dns-service-ip 10.2.0.10 \
    --service-cidr 10.2.0.0/24 \
    --generate-ssh-keys

    