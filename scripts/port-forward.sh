# chmod +x port-forward.sh
#!/bin/bash

NAMESPACE=$1

if [ -z "$NAMESPACE" ]; then
  echo "Uso: ./port-forward.sh <namespace>"
  exit 1
fi

echo "Redirecionando portas para o namespace '$NAMESPACE'..."

kubectl port-forward svc/postgres 5432:5432 -n $NAMESPACE &
echo "✔️ Postgres (5432)"

kubectl port-forward svc/n8n 5678:5678 -n $NAMESPACE &
echo "✔️ N8N (5678)"

kubectl port-forward svc/evolution 8080:8080 -n $NAMESPACE &
echo "✔️ Evolution (8080)"

echo "Para encerrando todos os processos 'kubectl port-forward'"
echo