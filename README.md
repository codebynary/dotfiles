# ⚡ CodeBy.Dev // Dotfiles

<p align="center">
  <img src="assets/banner.png" alt="Dotfiles Banner" width="100%">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Release-v2.1.0-blue?style=for-the-badge&logo=github" alt="Version">
  <img src="https://img.shields.io/badge/System-Windows%20%7C%20Debian-eb3c27?style=for-the-badge&logo=linux" alt="OS">
  <img src="https://img.shields.io/badge/Status-Stable-success?style=for-the-badge" alt="Status">
</p>

---

## 💎 A Proposta (v2.1)

Este repositório é o seu "centro de comando" para configurar novos ambientes em minutos. Agora com suporte a **Perfís Privados**, **Menu Interativo** e **Auto-Correção de Dependências**.

### 🛠️ Ferramentas Incluídas

| Categoria | Softwares |
| :--- | :--- |
| **Core** | Git, GitHub CLI |
| **Virtualização** | Docker Desktop, WSL 2 |
| **Linguagens** | Node.js (NVM), Python (Pyenv) |
| **Editores** | **VS Code, Cursor AI** |
| **Browsers** | **Brave Browser**, Google Chrome |
| **Dev Tools** | **Postman, DBeaver** |
| **Comunicação** | Discord, Slack |

---

## 🪟 Windows (setup.ps1)

O script de Windows conta com inteligência de auto-recuperação personalizada.

### Peculiaridades:
- **Auto-Fix Winget**: Detecta se o `winget` está no PATH e corrige na sessão atual.
- **Bootstrap Automático**: Se o sistema não tiver o `winget`, o script se oferece para baixar e instalar o instalador oficial do GitHub.
- **Perfis de Usuário**: Sincroniza `.gitconfig` e preferências baseadas no usuário logado em `profiles/`.

### Como rodar:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; . .\scripts\windows\setup.ps1
```

---

## 🐧 Linux / WSL (setup.sh)

Focado em distribuições baseadas em Debian/Ubuntu.

### Peculiaridades:
- **Gestor APT Automático**: Configura repositórios oficiais para ferramentas como VS Code e Brave.
- **Modularidade de Perfis**: Mesma estrutura de pastas do Windows para manter a consistência entre sistemas.
- **Relatório de Instalação**: Gera um log detalhado de cada pacote instalado.

### Como rodar:
```bash
chmod +x scripts/linux/setup.sh && ./scripts/linux/setup.sh
```

---

## 📂 Profiles Privados

Para manter sua privacidade ao compartilhar este repo:
1. O diretório `profiles/` está protegido por `.gitignore`.
2. O script detecta automaticamente o nome do usuário logado.
3. As personalizações (como `.gitconfig`) são aplicadas após a instalação base.

---
<div align="center">
  <p>Mantido por</p>
  <h3>💠 CodeBy.Dev 💠</h3>
</div>
