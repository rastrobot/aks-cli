#!/bin/bash

# setup-monitoring.sh
# minikube service prometheus-grafana -n monitoring --url
# minikube service prometheus-prometheus -n monitoring --url
#!/bin/bash

# setup-monitoring.sh

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Função para exibir mensagens
print_message() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

# Função para verificar se comando existe
check_command() {
    if ! command -v $1 &> /dev/null; then
        print_error "$1 não encontrado. Por favor, instale primeiro."
        exit 1
    fi
}

# Função para verificar status do Minikube
check_minikube() {
    if ! minikube status | grep -q "Running"; then
        print_error "Minikube não está rodando"
        print_message "Iniciando Minikube..."
        minikube start --memory=4096 --cpus=2
    fi
}

# Função para verificar status do pod
check_pod_status() {
    namespace=$1
    pod_prefix=$2
    
    print_message "Verificando status do pod $pod_prefix..."
    
    # Esperar até 5 minutos pelo pod ficar pronto
    for i in {1..30}; do
        if kubectl get pods -n $namespace | grep $pod_prefix | grep -q "Running"; then
            print_message "Pod $pod_prefix está rodando!"
            return 0
        fi
        print_warning "Aguardando pod $pod_prefix... (${i}/30)"
        sleep 10
    done
    
    # Se chegou aqui, pod não está rodando
    print_error "Pod $pod_prefix não está rodando. Logs:"
    kubectl get pods -n $namespace | grep $pod_prefix
    kubectl describe pod -n $namespace $(kubectl get pods -n $namespace | grep $pod_prefix | awk '{print $1}')
    return 1
}

# Função para obter URL do serviço
get_service_url() {
    namespace=$1
    service=$2
    
    print_message "Obtendo URL do serviço $service..."
    
    # Tentar até 5 vezes
    for i in {1..5}; do
        url=$(minikube service $service -n $namespace --url 2>/dev/null)
        if [ $? -eq 0 ] && [ ! -z "$url" ]; then
            echo $url
            return 0
        fi
        print_warning "Tentativa ${i}/5: Serviço não disponível ainda..."
        sleep 10
    done
    
    print_error "Não foi possível obter URL do serviço $service"
    return 1
}

# Verificar dependências
print_message "Verificando dependências..."
check_command kubectl
check_command helm
check_command minikube

# Verificar Minikube
check_minikube

# Criar namespace
print_message "Criando namespace monitoring..."
kubectl create namespace monitoring 2>/dev/null || true

# Remover instalação anterior se existir
print_message "Limpando instalações anteriores..."
helm uninstall prometheus -n monitoring 2>/dev/null || true
kubectl delete pvc --all -n monitoring 2>/dev/null || true
sleep 10

# Adicionar repositório Helm
print_message "Adicionando repositório Helm do Prometheus..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Configurações do Prometheus Stack
cat << EOF > monitoring-values.yaml
grafana:
  adminPassword: admin123
  service:
    type: NodePort
  persistence:
    enabled: true
    size: 1Gi
  resources:
    requests:
      memory: "256Mi"
      cpu: "250m"
    limits:
      memory: "512Mi"
      cpu: "500m"

prometheus:
  service:
    type: NodePort
  persistence:
    enabled: true
    size: 1Gi
  resources:
    requests:
      memory: "256Mi"
      cpu: "250m"
    limits:
      memory: "512Mi"
      cpu: "500m"

alertmanager:
  persistence:
    enabled: true
    size: 1Gi
  resources:
    requests:
      memory: "128Mi"
      cpu: "100m"
    limits:
      memory: "256Mi"
      cpu: "200m"
EOF

# Instalar Prometheus Stack
print_message "Instalando Prometheus Stack..."
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --values monitoring-values.yaml

# Aguardar pods ficarem prontos
sleep 30  # Dar tempo para os pods iniciarem

# Verificar status dos pods principais
check_pod_status monitoring "prometheus-grafana" || exit 1
check_pod_status monitoring "prometheus-kube-prometheus-prometheus" || exit 1

# Obter URLs dos serviços
GRAFANA_URL=$(get_service_url monitoring "prometheus-grafana")
PROMETHEUS_URL=$(get_service_url monitoring "prometheus-kube-prometheus-prometheus")

# Exibir informações
if [ ! -z "$GRAFANA_URL" ] && [ ! -z "$PROMETHEUS_URL" ]; then
    cat << EOF

${GREEN}=== Stack de Monitoramento Instalado com Sucesso ===${NC}

Grafana:
  URL: ${GRAFANA_URL}
  Usuário: admin
  Senha: admin123

Prometheus:
  URL: ${PROMETHEUS_URL}

Para verificar status:
  kubectl get pods -n monitoring

Para ver logs do Grafana:
  kubectl logs -n monitoring -l app.kubernetes.io/name=grafana

Para remover:
  helm uninstall prometheus -n monitoring
  kubectl delete namespace monitoring

EOF
else
    print_error "Falha ao obter URLs dos serviços. Verifique o status com: kubectl get all -n monitoring"
    exit 1
fi
