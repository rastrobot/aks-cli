#!/bin/bash

# Verifica se o Zsh está instalado
if ! command -v zsh >/dev/null 2>&1; then
  echo "Instalando Zsh..."
  sudo apt install zsh -y
fi

# Instala Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Instalando Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Instala Powerlevel10k
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  echo "Instalando tema Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Instala plugins
echo "Instalando plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Gera .zshrc com configuração padrão
echo "Configurando .zshrc..."

cat > ~/.zshrc <<EOF
export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git kubectl zsh-autosuggestions zsh-syntax-highlighting command-not-found)
source \$ZSH/oh-my-zsh.sh

alias k='kubectl'
alias kctx='kubectl config use-context'
alias kns='kubectl config set-context --current --namespace'

HIST_STAMPS="mm/dd/yyyy"
source \${ZSH_CUSTOM:-\$ZSH/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source \${ZSH_CUSTOM:-\$ZSH/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
REPORTTIME=2
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
EOF

echo "✅ Finalizado! Agora abra um novo terminal ou rode: zsh"
echo "🔤 Lembre-se de configurar a fonte 'MesloLGS NF' no Terminator para visualizar corretamente."

echo Instalar fonte: https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#fonts