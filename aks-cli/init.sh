#!/bin/bash

echo "🔑 Configurando credenciais do cluster..."
az aks get-credentials --resource-group rg-aks-dev --name aks-dev --overwrite-existing

echo "📁 Copiando config para .config-container..."
mkdir -p .config-container/.kube
cp ~/.kube/config .config-container/.kube/

echo "✅ Configuração concluída."

# docker run -it --rm \
#   -v $PWD/.config-container:/home/user \
#   -v $PWD:/workspace \
#   --env HOME=/home/user \
#   --workdir /workspace \
#   aks-cli \
#   bash --rcfile /workspace/aks-cli/k-function.sh