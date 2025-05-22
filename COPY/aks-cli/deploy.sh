#!/bin/bash
set -e

echo "============================================================"
echo "🚀 Iniciando Deploy Completo..."
echo "📅 Data/Hora: $(date)"
echo "🔗 Contexto atual: $(kubectl config current-context)"
echo "============================================================"

# Ingress NGINX
echo "🔧 Aplicando Ingress NGINX e Cert-Manager..."
kubectl apply -k infra
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