kubectl apply -k k8s/


kubectl apply -k k8s/overlays/dev
kubectl apply -k k8s/overlays/prod
kubectl apply -k k8s/overlays/staging

Se quiser 100% de confiança no que vai mudar, pode usar:
kubectl diff -k overlays/dev

Para ver o timestamp exato da criação do Pod:
kubectl get pod dev-n8n-123 -o jsonpath="{.metadata.creationTimestamp}"

# Se algum Pod está em erro, travado ou com problemas
kubectl get pods --all-namespaces

# Se quiser mostrar só os Pods com erro, um comando mais filtrado:
kubectl get pods --all-namespaces | grep -v Running | grep -v Completed

# Para checar a última mensagem de erro de todos os Pods:
kubectl describe pods --all-namespaces | grep -i "reason"

# listar só os Pods com erro ou crash 
kubectl get pods --all-namespaces | grep -E "CrashLoopBackOff|Error|Pending"

# Se os Pods ficarem muito tempo em Terminating, você pode forçar a limpeza com:
kubectl delete pod <nome> --grace-period=0 --force

# Após usar namespace
kubectl get all -n dev

# Se quiser ficar fixado num namespace para evitar digitar -n dev toda hora:
kubectl config set-context --current --namespace=dev

# Se quiser voltar pro default, é só fazer:
kubectl config set-context --current --namespace=default

# Se quiser ver tudo de todos os namespaces:
kubectl get pods -A
kubectl get all -A

# readinessProbe e livenessProbe.
	•	readinessProbe → verifica se o n8n responde no / na porta 5678 (considerado “pronto”).
	•	livenessProbe → fica monitorando se o n8n travou — se travar, mata e reinicia o Pod.
	•	initialDelaySeconds → dá tempo do app subir antes da primeira checagem.
	•	periodSeconds → frequência de checagem.


# 
kubectl apply -k overlays/dev
# Rollout é mais rápido pq nao precisa deletar ou replicar yaml, apenas cria um novo pod
kubectl rollout restart deployment dev-n8n -n dev
# Quando usar cada um?
	•	Pequenas mudanças de env/config?
➔ rollout restart
	•	Mudança de arquivos de infraestrutura (ex: Service, Ingress)?
➔ kubectl apply primeiro, depois rollout restart se necessário.

01234567890123456789012345678901234567890123456789012345678901234567890123456789