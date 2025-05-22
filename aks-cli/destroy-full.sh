#!/bin/bash
set -e

echo "============================================================"
echo "🧨 Destruição total iniciada (exceto IP fixo e kube-system)"
echo "📅 Data/Hora: $(date)"
echo "🔗 Contexto atual: $(kubectl config current-context)"
echo "============================================================"

# Automation (Dev)
echo "🗑️ Deletando Automation Dev..."
kubectl delete -k overlays/dev/automation || echo "⚠️ Automation já não existe."

# Shared
echo "🗑️ Deletando Shared..."
kubectl delete -k shared || echo "⚠️ Shared já não existe."

# Ingress NGINX
echo "🗑️ Deletando Ingress NGINX..."
kubectl delete -f ingress-nginx.yaml || echo "⚠️ Ingress NGINX já não existe."

# Cert-Manager
echo "🗑️ Deletando Cert-Manager..."
kubectl delete -k infra/cert-manager || echo "⚠️ Cert-Manager já não existe."

# Namespaces
echo "🗑️ Deletando Namespaces ingress-basic, cert-manager, shared, dev..."
kubectl delete ns ingress-basic --ignore-not-found
kubectl delete ns cert-manager --ignore-not-found
kubectl delete ns shared --ignore-not-found
kubectl delete ns dev --ignore-not-found

echo "============================================================"
echo "✅ Tudo removido com sucesso (exceto kube-system e IP fixo)."
echo "🏁 Fim às $(date)"
echo "============================================================"