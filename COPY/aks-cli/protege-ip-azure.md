
# 🛑 protege-ip-azure.md
## Guia para proteger IP fixo no Azure de deleção acidental

## ⚠️ Por que proteger?
Perder um IP fixo no Azure pode causar:
- Desconexão de dispositivos remotos (rastreadores, IoT, automação, veículos, etc.).
- Perda de acesso em firewalls, roteadores e serviços que confiam nesse IP.
- Grande dor de cabeça para reconfigurar todos os dispositivos.

## ✅ Passo 1 — Verificar se o IP está correto

```bash
az network public-ip list \
  --query "[?ipAddress=='74.235.217.165'].{Name:name, ResourceGroup:resourceGroup}" \
  -o table
```

✔️ Anote:
- **Nome do IP:** ingress-public-ip
- **Resource Group:** MC_rg-aks-dev_aks-dev_eastus

## 🔒 Passo 2 — Aplicar lock de proteção no IP

```bash
az lock create \
  --name LockIngressPublicIP \
  --lock-type CanNotDelete \
  --resource-group MC_rg-aks-dev_aks-dev_eastus \
  --resource ingress-public-ip \
  --resource-type "Microsoft.Network/publicIPAddresses"
```

✔️ Isso impede que você (ou qualquer outra pessoa) delete esse IP pelo portal, CLI ou API.

## 🔐 (Opcional) Aplicar lock no resource group inteiro

```bash
az lock create \
  --name LockRGIngress \
  --lock-type CanNotDelete \
  --resource-group MC_rg-aks-dev_aks-dev_eastus
```

✔️ Isso protege **todos os recursos dentro do RG**, incluindo IP, LoadBalancer, VNet, NSG, etc.

## 🔎 Verificar locks ativos

```bash
az lock list --output table
```

## 🔓 Remover lock (se realmente quiser deletar)

```bash
az lock delete --name LockIngressPublicIP --resource-group MC_rg-aks-dev_aks-dev_eastus
```

Ou, para o resource group inteiro:

```bash
az lock delete --name LockRGIngress --resource-group MC_rg-aks-dev_aks-dev_eastus
```

## 🏆 Boas práticas

- ✔️ Crie o IP manualmente no Azure, fora do ciclo automático do AKS.
- ✔️ Sempre defina no YAML do service:

```yaml
spec:
  loadBalancerIP: 74.235.217.165
```

- ✔️ Sempre aplique o lock imediatamente após criar o IP.

## 🚀 Status atual — IP protegido

| Recurso           | IP               | Protegido |
|-------------------|------------------|-----------|
| ingress-public-ip | 74.235.217.165   | ✅         |


🔥 Quer proteção máxima?
	•	Aplique também um lock no resource group MC_rg-aks-dev_aks-dev_eastus inteiro:

az lock create \
  --name LockRGIngress \
  --lock-type CanNotDelete \
  --resource-group MC_rg-aks-dev_aks-dev_eastus  