#!/bin/bash
set -e

SEPARATOR="============================================================"

echo "$SEPARATOR"
echo "🧨 Iniciando destruição controlada..."
echo "📅 Data/Hora: $(date)"
echo "🔗 Contexto atual: $(kubectl config current-context)"
echo "$SEPARATOR"

# 🔥 Automation Dev
echo "🗑️ Deletando Automation Dev..."
kubectl delete -k overlays/dev/automation || echo "⚠️ Automation já não existe."
echo "$SEPARATOR"

# 🔥 Shared (Redis e Postgres)
echo "🗑️ Deletando Shared..."
kubectl delete -k shared || echo "⚠️ Shared já não existe."
echo "$SEPARATOR"

# 🔥 Ingress NGINX
echo "🗑️ Deletando Ingress NGINX..."
kubectl delete -f ingress-nginx.yaml || echo "⚠️ Ingress NGINX já não existe."
echo "$SEPARATOR"

# 🔥 Cert-Manager (HTTPS)
echo "🗑️ Deletando Cert-Manager..."
kubectl delete -k infra/cert-manager || echo "⚠️ Cert-Manager já não existe."
echo "$SEPARATOR"

echo "✅ Infraestrutura Kubernetes removida com sucesso (IP fixo preservado)."
echo "🏁 Fim às $(date)"
echo "$SEPARATOR"