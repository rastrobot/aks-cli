# chmod +x check-pods-status.sh
#!/bin/bash

echo "🔍 Verificando Pods com problema..."

kubectl get pods --all-namespaces | grep -E "CrashLoopBackOff|Error|Pending"

echo ""
echo "✅ Análise finalizada. Se não apareceu nada acima, todos os Pods estão OK."