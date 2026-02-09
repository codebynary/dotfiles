# ⚡ CodeBy.Dev // Dotfiles

<p align="center">
  <img src="https://img.shields.io/badge/Release-v1.0.0-blue?style=for-the-badge&logo=github" alt="Version">
  <img src="https://img.shields.io/badge/System-Windows%20%7C%20Debian-eb3c27?style=for-the-badge&logo=linux" alt="OS">
  <img src="https://img.shields.io/badge/Status-Stable-success?style=for-the-badge" alt="Status">
</p>

---

## 💎 A Proposta

Esqueça o tempo perdido configurando cada detalhe manualmente. Este repositório é a sua **"infraestrutura como código"** pessoal. Uma stack robusta, moderna e pronta para o combate, entregue em um único comando.

### 🎯 O que será instalado?

| Componente | Ferramenta | Descrição |
| :--- | :--- | :--- |
| **Virtualização** | 🐳 **Docker** | Containerization de nível industrial. |
| **Subsistema** | 🐧 **WSL 2** | Ubuntu (20/22) e Debian integrados. |
| **JS Runtime** | 🟢 **NVM** | Gestão de múltiplas versões do Node.js. |
| **Py Runtime** | 🐍 **Pyenv** | Gestão de ambientes isolados Python. |
| **Git Tooling** | 🐙 **Git & GH** | Controle de versão e CLI do GitHub. |
| **AI Powered** | ⚛️ **Antigravity** | Seu parceiro de codificação avançado. |

---

## 🛠️ Instalação Rápida

Escolha o seu ambiente e execute o comando abaixo no terminal:

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
  <p>Mantido com rigor por</p>
  <h3>💠 CodeBy.Dev 💠</h3>
</div>
