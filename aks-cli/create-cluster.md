# APAGAR TUDO
az aks delete --name aks-dev --resource-group rg-aks-dev --yes --no-wait
az group delete --name rg-aks-dev --yes --no-wait

# CRIAR NAMESPACE
az group create --name rg-aks-dev --location eastus

# CRIAR CLUSTER
```
NOME_RG="rg-aks-dev"
CLUSTER="aks-dev"
NODE_COUNT=1

az aks create \
  --resource-group $NOME_RG \
  --name $CLUSTER \
  --node-count $NODE_COUNT \
  --node-vm-size Standard_B2s \
  --generate-ssh-keys
```
  ---- OU ----
```
az aks create \
  --resource-group rg-aks-dev \
  --name aks-dev \
  --node-count 1 \
  --node-vm-size Standard_B2s \
  --generate-ssh-keys
```
# AJUSTAR CREDENCIAIS
az aks get-credentials --resource-group rg-aks-dev --name aks-dev --overwrite-existing

# TESTAR
kubectl get nodes




  az aks get-credentials --resource-group $NOME_RG --name $CLUSTER

  kubectl get nodes

  