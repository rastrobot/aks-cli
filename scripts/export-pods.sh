#!/bin/zsh

NAMESPACE=$1

if [[ -z "$NAMESPACE" ]]; then
  echo "Uso: source ./export-pods.sh <namespace>"
  return 1
fi

for entry in $(kubectl get pods -n "$NAMESPACE" -o json | jq -r '.items[] | select(.metadata.labels.app) | "\(.metadata.labels.app)=\(.metadata.name)"'); do
  key="${entry%%=*}"
  value="${entry#*=}"
  export $key=$value
  echo "export $key=$value"
done