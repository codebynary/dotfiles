#!/bin/bash
# setup.sh - Dotfiles Evolution v2.1 (Linux)
# By: CodeBy.Dev

set -e

# Cores ANSI
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
GRAY='\033[0;90m'
MAGENTA='\033[0;35m'
RESET='\033[0m'

show_header() {
    clear
    echo -e "${CYAN}"
    echo "------------------------------------------------------------"
    echo "  ####  ####  ####  ##### ####  #   #    ####  ##### #   #"
    echo " #     #    # #   # #     #   #  # #     #   # #     #   #"
    echo " #     #    # #   # ####  ####    #      #   # ####   # # "
    echo " #     #    # #   # #     #   #   #      #   # #      # # "
    echo "  ####  ####  ####  ##### ####    #      ####  #####   #  "
    echo ""
    echo "            >>> Dotfiles // Environment Setup <<<           "
    echo "------------------------------------------------------------"
    echo -e "${RESET}"
    echo -e "  ${GRAY}[+] Stack de Desenvolvimento Automatizada (Linux)${RESET}"
    echo -e "  ${GRAY}[+] Pronto para configurar seu ambiente${RESET}\n"
}

# Lista de Apps (ID;Nome;Categoria)
apps=(
    "git;Git;Core"
    "gh;GitHub CLI;Core"
    "docker;Docker;Virtualizacao"
    "nvm;Node.js (NVM);Linguagens"
    "pyenv;Python (Pyenv);Linguagens"
    "vscode;VS Code;Editores"
    "cursor;Cursor AI;Editores"
    "brave;Brave Browser;Browsers"
    "postman;Postman;Dev Tools"
    "dbeaver;DBeaver;Dev Tools"
)

show_menu() {
    echo -e "${YELLOW}Selecione as ferramentas para instalar (Ex: 1 2 5 ou 'A'):${RESET}"
    count=1
    for item in "${apps[@]}"; do
        IFS=';' read -r id name cat <<< "$item"
        echo -e "  $count. [$cat] $name"
        ((count++))
    done
    echo -e "\n  A. Instalar TUDO"
    echo -e "  Q. Sair\n"
}

show_header
show_menu

read -p "Opcao: " selection

targets=()
if [[ "$selection" == "A" || "$selection" == "all" ]]; then
    targets=("${apps[@]}")
elif [[ "$selection" == "Q" || "$selection" == "q" ]]; then
    exit 0
else
    # Suporta selecao separada por espaco ou virgula
    for idx in ${selection//,/ }; do
        target_idx=$((idx-1))
        if [[ $target_idx -ge 0 && $target_idx -lt ${#apps[@]} ]]; then
            targets+=("${apps[$target_idx]}")
        fi
    done
fi

if [ ${#targets[@]} -eq 0 ]; then
    echo -e "${MAGENTA}Nenhuma selecao valida. Saindo...${RESET}"
    exit 0
fi

# Inicio da Instalacao
LOG_FILE="install_log_linux.txt"
echo "### Log de Instalacao Linux - $(date) ###" > "$LOG_FILE"

echo -e "\n${CYAN}[+] Atualizando repositorios...${RESET}"
sudo apt update -y

for item in "${targets[@]}"; do
    IFS=';' read -r id name cat <<< "$item"
    echo -e "\n${CYAN}[+] Instalando $name...${RESET}"
    
    success=false
    case $id in
        "git") sudo apt install -y git && success=true ;;
        "gh") # GitHub CLI
            type -p curl >/dev/null || sudo apt install curl -y
            sudo mkdir -p -m 755 /etc/apt/keyrings
            curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
            sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
            sudo apt update && sudo apt install gh -y && success=true
            ;;
        "docker")
            curl -fsSL https://get.docker.com | sudo sh && success=true
            ;;
        "nvm")
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash && success=true
            ;;
        "pyenv")
            curl https://pyenv.run | bash && success=true
            ;;
        "vscode")
            sudo apt install -y software-properties-common apt-transport-https wget
            wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
            sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
            sudo apt update && sudo apt install -y code && success=true
            ;;
        "brave")
            sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
            echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
            sudo apt update && sudo apt install -y brave-browser && success=true
            ;;
        *)
            echo "Instalacao automatica indisponivel para $id via apt."
            ;;
    esac

    if [ "$success" = true ]; then
        echo "$name: SUCESSO" >> "$LOG_FILE"
        echo -e "    ${GREEN}Concluido!${RESET}"
    else
        echo "$name: FALHA" >> "$LOG_FILE"
        echo -e "    ${MAGENTA}Erro na instalacao.${RESET}"
    fi
done

# Verificacao de Perfil
PROFILE_PATH="../../profiles/$USER"
if [ -d "$PROFILE_PATH" ]; then
    echo -e "\n${MAGENTA}[!] Perfil localizado para $USER. Aplicando customizacoes...${RESET}"
    if [ -f "$PROFILE_PATH/.gitconfig" ]; then
        cp "$PROFILE_PATH/.gitconfig" "$HOME/.gitconfig"
        echo "Profile: .gitconfig atualizado" >> "$LOG_FILE"
        echo -e "    -> .gitconfig aplicado."
    fi
fi

echo -e "\n${GREEN}--- Script Finalizado! ---${RESET}"
echo -e "Verifique o log em: $LOG_FILE"
echo -e "CodeBy.Dev // 2026"
