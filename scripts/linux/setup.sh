#!/bin/bash
# setup.sh - Automação de Ambiente Debian

set -e

echo "--- Iniciando Setup do Ambiente Dev (Debian/Linux) ---"

# 1. Garantir pasta Dev
DEV_PATH="$HOME/Dev"
if [ ! -d "$DEV_PATH" ]; then
    echo "Criando pasta Dev..."
    mkdir -p "$DEV_PATH"
fi

# 2. Atualizar Sistema
sudo apt update && sudo apt upgrade -y

# 3. Instalar Dependências Básicas
sudo apt install -y curl git build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# 4. GitHub CLI
if ! command -v gh &> /dev/null; then
    echo "Instalando GitHub CLI..."
    type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
fi

# 5. Docker
if ! command -v docker &> /dev/null; then
    echo "Instalando Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    rm get-docker.sh
fi

# 6. NVM (Node Version Manager)
if [ ! -d "$HOME/.nvm" ]; then
    echo "Instalando NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi

# 7. Pyenv
if [ ! -d "$HOME/.pyenv" ]; then
    echo "Instalando Pyenv..."
    curl https://pyenv.run | bash
fi

# 8. Antigravity
if ! command -v antigravity &> /dev/null; then
    echo "Instalando Antigravity..."
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://antigravity.google/apt/key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/antigravity.gpg
    echo "deb [signed-by=/etc/apt/keyrings/antigravity.gpg] https://antigravity.google/apt stable main" | sudo tee /etc/apt/sources.list.d/antigravity.list
    sudo apt update
    sudo apt install antigravity -y
fi

echo "--- Setup Concluído! ---"
echo "Por favor, reinicie sua sessão ou execute 'source ~/.bashrc' para aplicar as mudanças."
