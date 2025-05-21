az login && az aks get-credentials --resource-group rg-aks-dev --name aks-dev-clean --overwrite-existing && kubectl get pods -n infra | grep ingress-nginx-controller
kubectl apply -k k8s/overlays/dev/automation && echo "Aguardando ingress atualizar..." && sleep 5 && kubectl get ingress -n dev
kubectl apply -k k8s/overlays/dev/automation && echo "Aguardando ingress atualizar..." && sleep 5 && kubectl get ingress -n dev
kubectl get pods -A
k
alias k=kubectl
k get namespace -A
k delete namespace dev
k delete namespace dev-automation
k delete namespace infra
k get namespace -A
k get pods -A
k get all -A
az aks delete -g rg-aks-dev -n aks-dev-clean --yes --no-wait
az group delete -n rg-aks-dev --yes --no-wait
k get all -A
kubectl get crd
kubectl get pv
kubectl get pvc -A
kubectl get ingressclass
kubectl get clusterrole | grep ingress
kubectl get clusterrolebinding | grep ingress
az aks delete --name aks-dev --resource-group rg-aks-dev --yes --no-wait
az group delete --name rg-aks-dev --yes --no-wait
az aks create   --resource-group rg-aks-dev   --name aks-dev   --node-count 1   --node-vm-size Standard_B2s   --generate-ssh-keys
az aks create   --resource-group rg-aks-dev   --name aks-dev   --node-count 1   --node-vm-size Standard_B2s   --generate-ssh-keys
az group create --name rg-aks-dev --location eastus
k get all -A
az aks create   --resource-group rg-aks-dev   --name aks-dev   --node-count 1   --node-vm-size Standard_B2s   --generate-ssh-keys
k get all -A
az aks list -o table
kubectl config view
az account list -o table
kubectl get nodes --context aks-dev-clean
kubectl config delete-context aks-dev-clean
kubectl config delete-cluster aks-dev-clean
kubectl config unset users.clusterUser_rg-aks-dev_aks-dev-clean
kubectl config get-contexts
kubectl config get-clusters
kubectl config view -o jsonpath="{.users[*].name}"
kubectl get nodes
kubectl config use-context aks-dev
kubectl get nodes
kubectl get nodes
k get all -A
az aks list -o table
ping google.com
nslookup aks-dev-rg-aks-dev-9f59b0-lklboxs9.hcp.eastus.azmk8s.io
az aks get-credentials --resource-group rg-aks-dev --name aks-dev --overwrite-existing
kubectl get nodes
az aks get-credentials --resource-group rg-aks-dev --name aks-dev --overwrite-existing
k apply -k COPY
ls
exit
