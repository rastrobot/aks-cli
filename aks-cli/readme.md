docker build -t aks-cli .

cd ~/Downloads/testes/kompose-convert/aks-cli

docker run -it --rm \
  -v $HOME/.kube:/root/.kube \
  -v $HOME/.azure:/root/.azure \
  -v $HOME/Downloads/testes/kompose-convert/k8s:/root/k8s \
  aks-cli





Verificar conta logada
```
az account show
```
---

Listar assinatura disponível
```
az account list -o table
```
---

```
az login
```
---

Liste seus clusters (opcional)
```
az aks list -o table
```
---

Conecte-se ao AKS
```
az aks get-credentials --resource-group MEU-GRUPO --name MEU-CLUSTER
```
---

Teste o acesso
```
kubectl get nodes
```
---

Abrir portal logado na conta
```
az portal open
```