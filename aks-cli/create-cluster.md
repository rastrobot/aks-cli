NOME_RG="rg-aks-dev"
CLUSTER="aks-dev"
NODE_COUNT=1

az aks create \
  --resource-group $NOME_RG \
  --name $CLUSTER \
  --node-count $NODE_COUNT \
  --node-vm-size Standard_B2s \
  --generate-ssh-keys


  az aks get-credentials --resource-group $NOME_RG --name $CLUSTER

  kubectl get nodes

  