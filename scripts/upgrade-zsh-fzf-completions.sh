#!/bin/bash

echo "🔧 Instalando fzf via Homebrew..."
brew install fzf

echo "⚙️ Configurando fzf..."
"$(brew --prefix)/opt/fzf/install" --all

echo "📦 Clonando plugin zsh-completions..."
git clone https://github.com/zsh-users/zsh-completions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions

echo "📝 Garantindo que zsh-completions esteja no .zshrc..."
if ! grep -q "zsh-completions" ~/.zshrc; then
  sed -i '' 's/^plugins=(\(.*\))/plugins=(\1 zsh-completions)/' ~/.zshrc
fi

echo "✅ Atualizando sessão atual..."
source ~/.zshrc

echo "🚀 Tudo pronto! Use Ctrl+R para buscar comandos com fzf!"

