#!/bin/bash
echo "Aplicando Shared..."
kubectl apply -k shared

echo "Aplicando Ingress NGINX..."
kubectl apply -f ingress-nginx.yaml

echo "Aplicando Automation Dev..."
kubectl apply -k overlays/dev/automation

echo "✔️ Deploy concluído"