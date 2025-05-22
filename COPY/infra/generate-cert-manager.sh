#!/bin/bash
set -e

NAMESPACE="cert-manager"
VERSION="v1.14.4"
OUTPUT_PATH="infra/cert-manager"

echo "🚀 Gerando cert-manager.yaml na versão $VERSION..."

# Cria o diretório se não existir
mkdir -p $OUTPUT_PATH

# Adiciona o repositório do cert-manager
helm repo add jetstack https://charts.jetstack.io || true

# Atualiza os repositórios
helm repo update

# Gera o YAML do cert-manager
helm template cert-manager jetstack/cert-manager \
  --namespace $NAMESPACE \
  --version $VERSION \
  --set installCRDs=true \
  > $OUTPUT_PATH/cert-manager.yaml

echo "✅ Arquivo gerado em: $OUTPUT_PATH/cert-manager.yaml"