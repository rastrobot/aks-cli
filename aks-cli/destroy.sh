#!/bin/bash
echo "Deletando Automation Dev..."
kubectl delete -k overlays/dev/automation

echo "Deletando Ingress NGINX..."
kubectl delete -f ingress-nginx.yaml

echo "Deletando Shared..."
kubectl delete -k shared

echo "✔️ Infraestrutura removida (exceto IP fixo)"