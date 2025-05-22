
# Infraestrutura Kubernetes

Este diretório contém os manifests de infraestrutura base:

- **Ingress NGINX**
- **Cert-Manager**
- **Namespaces (ingress-basic e cert-manager)**

## 🛠️ Passo a passo para instalação

### 1️⃣ Instalar o Cert-Manager

Execute o script abaixo para adicionar o repositório Helm e instalar o Cert-Manager:

```bash
chmod +x generate-cert-manager.sh
./generate-cert-manager.sh
```

Esse script instala o Cert-Manager via Helm na namespace `cert-manager`.

---

### 2️⃣ Aplicar a infraestrutura

Execute:

```bash
kubectl apply -k infra/
```

⚠️ **Atenção:**  
É esperado um erro semelhante a este na primeira execução:

```
Error from server (InternalError): failed calling webhook "webhook.cert-manager.io": no endpoints available for service "cert-manager-webhook"
```

Esse erro ocorre porque o Cert-Manager ainda está inicializando.

---

### 3️⃣ Como resolver o erro (passo obrigatório):

1. Aguarde alguns segundos até todos os pods do Cert-Manager estarem `Running`:

```bash
kubectl get pods -n cert-manager
```

2. Execute novamente:

```bash
kubectl apply -k infra/
```

Agora irá aplicar sem erros.

---

## 🔁 Reaplicando ou destruindo

- Para destruir a infraestrutura mantendo apenas o IP fixo, use:

```bash
chmod +x destroy.sh
./destroy.sh
```

---

## ✅ Observação

- Este diretório não inclui recursos de aplicações, apenas a infraestrutura base para suportar os ambientes.
