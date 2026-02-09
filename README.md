# Dotfiles - Automação de Ambiente

Repositório central para configuração e automação dos meus ambientes de desenvolvimento (Windows e Debian).

## Estrutura
- `/scripts/windows`: Scripts PowerShell para configuração no Windows (Winget, WSL, Docker, nvm, pyenv).
- `/scripts/linux`: Scripts Bash para configuração no Debian.

## Como usar

### Windows
Abra o PowerShell como Administrador e execute:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/cfabioalves/dotfiles/main/scripts/windows/setup.ps1'))
```

### Debian
```bash
curl -fsSL https://raw.githubusercontent.com/cfabioalves/dotfiles/main/scripts/linux/setup.sh | bash
```
