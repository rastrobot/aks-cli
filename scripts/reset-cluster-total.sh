# chmod +x reset-cluster-total.sh
#!/bin/bash

NAMESPACE=$1

if [ -z "$NAMESPACE" ]; then
  echo "Uso: ./port-forward.sh <namespace>"
  exit 1
fi

echo "🧨 Deletando cluster Minikube..."
minikube delete && \

echo "🚀 Iniciando novo cluster Minikube..."
minikube start && \

echo "📦 Aplicando namespaces..."
kubectl apply -f k8s/namespaces.yaml && \

echo "🧱 Aplicando ambiente DEV..."
kubectl apply -k overlays/$NAMESPACE && \

echo "Aguardando 5 segundos..."
sleep 2

#echo "Iniciando redirecionamentos de portas..."
# ./port-forward.sh $NAMESPACE 
#$(dirname "$0")/port-forward.sh $NAMESPACE

echo "✅ Ambiente DEV pronto! Abrindo dashboard..."
minikube dashboard --url