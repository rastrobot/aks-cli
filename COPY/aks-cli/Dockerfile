FROM ubuntu:22.04

# Evita prompts interativos
ENV DEBIAN_FRONTEND=noninteractive

# Instala dependências básicas e utilitários
RUN apt-get update && apt-get install -y \
    curl wget unzip git vim bash ca-certificates gnupg lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Instala o Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Instala kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl

# Instala Helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Instala k9s (opcional)
RUN curl -Lo /usr/local/bin/k9s https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz \
    && tar -xzf /usr/local/bin/k9s -C /usr/local/bin/ \
    && chmod +x /usr/local/bin/k9s

# Cria pasta para config do kubectl
RUN mkdir -p /root/.kube

# Define diretório de trabalho
WORKDIR /root

# Comando default ao iniciar o container
CMD [ "bash" ]