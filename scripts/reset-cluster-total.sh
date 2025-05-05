# chmod +x reset-cluster-total.sh
#!/bin/bash

echo "🧨 Deletando cluster Minikube..."
minikube delete && \

echo "🚀 Iniciando novo cluster Minikube..."
minikube start && \

echo "📦 Aplicando namespaces..."
kubectl apply -f k8s/namespaces.yaml && \

echo "🧱 Aplicando ambiente DEV..."
kubectl apply -k overlays/dev && \

echo "✅ Ambiente DEV pronto! Abrindo dashboard..."
minikube dashboard