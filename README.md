# ⚡ CodeBy.Dev // Dotfiles

<p align="center">
  <img src="assets/banner.png" alt="Dotfiles Banner" width="100%">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Release-v1.0.0-blue?style=for-the-badge&logo=github" alt="Version">
  <img src="https://img.shields.io/badge/System-Windows%20%7C%20Debian-eb3c27?style=for-the-badge&logo=linux" alt="OS">
  <img src="https://img.shields.io/badge/Status-Stable-success?style=for-the-badge" alt="Status">
</p>

---

## 💎 A Proposta

Esqueça o tempo perdido configurando cada detalhe manualmente. Este repositório é a sua **"infraestrutura como código"** pessoal. Uma stack robusta e moderna que não apenas instala suas ferramentas, mas também gerencia múltiplas versões de **Node.js (NVM)** e **Python (Pyenv)**, garantindo que seu ambiente esteja sempre pronto para qualquer projeto, entregue em um único comando.

### 🎯 O que será instalado?

| Componente | Ferramenta | Descrição |
| :--- | :--- | :--- |
| **Virtualização** | 🐳 **Docker** | Containerization de nível industrial para microserviços. |
| **Subsistema** | 🐧 **WSL 2** | Ubuntu (20/22) e Debian para um ambiente Linux nativo. |
| **JS Runtime** | 🟢 **NVM / nvm-win** | Gestão total de versões **Node.js** para flexibilidade total. |
| **Py Runtime** | 🐍 **Pyenv / win** | Isolamento e gestão de ambientes **Python** sem conflitos. |
| **Git Tooling** | 🐙 **Git & GH** | Sincronização impecável com GitHub via CLI oficial. |
| **AI Powered** | ⚛️ **Antigravity** | IA Agentic Avançada integrada para aceleração de código. |

---

## 🛠️ Instalação Rápida

Escolha o seu ambiente e execute o comando abaixo para instalar toda a stack, incluindo **Docker, WSL, NVM, Pyenv e Antigravity** de forma automática:

### 🪟 No Windows (Win 10/11)
> [!IMPORTANT]
> Execute o PowerShell como **Administrador**.

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/codebynary/dotfiles/main/scripts/windows/setup.ps1'))
```

### 🐧 No Debian / Ubuntu
> [!NOTE]
> Suporta arquiteturas x86_64 e ARM.

```bash
curl -fsSL https://raw.githubusercontent.com/codebynary/dotfiles/main/scripts/linux/setup.sh | bash
```

---

## 📂 Organização
- `scripts/windows/` - Automação via **Winget**.
- `scripts/linux/` - Automação via **APT**.

---
<div align="center">
  <p>Mantido por</p>
  <h3>💠 CodeBy.Dev 💠</h3>
</div>
