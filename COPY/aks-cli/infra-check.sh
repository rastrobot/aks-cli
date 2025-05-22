#!/bin/bash
set -e

echo "🔍 Verificando contexto atual..."
echo "Contexto: $(kubectl config current-context)"
echo "--------------------------------------------"

echo "📦 Verificando Pods:"
kubectl get pods -A -o wide
echo "--------------------------------------------"

echo "🌐 Verificando Services:"
kubectl get svc -A
echo "--------------------------------------------"

echo "🚪 Verificando Ingress:"
kubectl get ingress -A
echo "--------------------------------------------"

echo "🔐 Verificando Certificates (HTTPS):"
kubectl get certificates -A
echo "--------------------------------------------"

echo "🗂️ Verificando PersistentVolumeClaims:"
kubectl get pvc -A
echo "--------------------------------------------"

echo "🛑 Verificando Recursos no Azure:"
az resource list --output table --query "[].{Name:name, Type:type, ResourceGroup:resourceGroup, Location:location}"
echo "--------------------------------------------"

echo "✅ Verificação concluída."