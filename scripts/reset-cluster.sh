# chmod +x reset-cluster.sh
#!/bin/bash

echo "⚡ Apagando todos os recursos (pods, deployments, services, ingress, etc)..."
kubectl delete all --all

echo "⚡ Apagando todos os ConfigMaps..."
kubectl delete configmap --all

echo "⚡ Apagando todos os Secrets..."
kubectl delete secret --all

echo "⚡ Apagando todos os Ingresses..."
kubectl delete ingress --all

echo "✅ Limpeza concluída."

echo "🚀 Aplicando novamente todos os recursos do Kustomization..."
# kubectl apply -k k8s/overlays/dev

echo "✅ Reaplicação completa."

echo "🔍 Verificando status atual..."
kubectl get all