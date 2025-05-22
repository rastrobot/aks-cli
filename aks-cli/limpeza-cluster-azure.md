
# 🧹 Limpeza Completa do Cluster Kubernetes no Azure

## 🔥 Objetivo:
Remover toda a infraestrutura criada (deployments, pods, services, ingress, etc.) mantendo o IP fixo protegido.

---

## 🚀 Comandos executados para limpeza:

### ✅ 1. Deletar todos os Ingress
```bash
kubectl delete ingress --all -A
```

### ✅ 2. Deletar todos os Services
```bash
kubectl delete svc --all -A
```

### ✅ 3. Deletar todos os Deployments
```bash
kubectl delete deployment --all -A
```

### ✅ 4. Deletar todos os Pods (se sobrar algum)
```bash
kubectl delete pod --all -A
```

### ✅ 5. Deletar DaemonSets, ReplicaSets, StatefulSets e Jobs
```bash
kubectl delete daemonset --all -A
kubectl delete replicaset --all -A
kubectl delete statefulset --all -A
kubectl delete job --all -A
```

### ✅ 6. (Opcional) Deletar Namespaces personalizados
```bash
kubectl delete ns dev
kubectl delete ns ingress-basic
kubectl delete ns shared
```

### ✅ 7. Validar se tudo foi limpo
```bash
kubectl get all -A
kubectl get ns
kubectl get svc --all-namespaces
kubectl get ingress --all-namespaces
kubectl get deployments --all-namespaces
kubectl get pods --all-namespaces
kubectl get daemonset --all-namespaces
kubectl get replicaset --all-namespaces
kubectl get statefulset --all-namespaces
kubectl get job --all-namespaces
```

---

## ✅ Resultado esperado:
- Somente pods e serviços padrões do Kubernetes rodando (`coredns`, `metrics-server`, `kube-proxy`, etc.).
- Nenhum recurso da sua aplicação anterior permanece ativo.
