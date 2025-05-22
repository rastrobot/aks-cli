1. Criar IP estático manual:

az network public-ip create \
  --resource-group rg-aks-dev \
  --name ingress-public-ip \
  --sku Standard \
  --allocation-method Static

  2. Recuperar o IP:

  az network public-ip show \
  --resource-group rg-aks-dev \
  --name ingress-public-ip \
  --query ipAddress -o tsv

  3. Vincular esse IP ao LoadBalancer (via Helm ou YAML):


helm upgrade nginx-ingress ingress-nginx/ingress-nginx \
  --namespace ingress-basic \
  --set controller.service.loadBalancerIP=<IP_FIXO>

  Agora, mesmo que você exclua e recrie o AKS ou o Ingress, o IP permanece com você, desde que:
	•	Não delete o recurso Public IP na Azure manualmente.
	•	Reassocie o IP no novo cluster/serviço.


🔥 📌 Atenção sobre IP Estático no Azure:
•	O IP não está vinculado diretamente ao AKS.
Ele está vinculado ao resource group do cluster (MC_rg-aks-dev_aks-dev_eastus), como um Public IP Resource.
•	⚠️ Se você deletar o Service LoadBalancer, o IP se libera, a menos que esteja vinculado manualmente via loadBalancerIP no YAML.