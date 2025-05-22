#!/bin/bash
set -e

echo "============================================================"
echo "🚀 Iniciando Deploy Completo..."
echo "📅 Data/Hora: $(date)"
echo "🔗 Contexto atual: $(kubectl config current-context)"
echo "============================================================"

# Ingress NGINX
echo "🔧 Aplicando Ingress NGINX e Cert-Manager..."
kubectl apply -f ingress-nginx.yaml
echo "------------------------------------------------------------"

# # Cert-Manager
# echo "🔐 Aplicando Cert-Manager..."
# kubectl apply -k infra/cert-manager
# echo "------------------------------------------------------------"

# ClusterIssuer (HTTPS Let's Encrypt)
echo "🔐 Aplicando ClusterIssuer..."
kubectl apply -f infra/clusterissuer.yaml
echo "------------------------------------------------------------"

# Shared (Redis, Postgres)
echo "🗄️ Aplicando Shared..."
kubectl apply -k shared
echo "------------------------------------------------------------"

# Automation Dev (N8N, Evolution)
echo "🤖 Aplicando Automation Dev..."
kubectl apply -k overlays/dev/automation
echo "------------------------------------------------------------"

echo "✅ Deploy concluído com sucesso!"
echo "============================================================"