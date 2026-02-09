# setup.ps1 - Automação de Ambiente Windows
# Execute como Administrador

Write-Host "--- Iniciando Setup do Ambiente Deva (Windows) ---" -ForegroundColor Cyan

# 1. Garantir pasta Dev
$devPath = "C:\Users\$env:USERNAME\Dev"
if (-not (Test-Path $devPath)) {
    Write-Host "Criando pasta Dev..."
    New-Item -ItemType Directory -Path $devPath
}

# 2. Atualizar Winget (se necessário)
Write-Host "Atualizando catálogo do Winget..."
winget source update

# 3. Lista de Ferramentas
$apps = @(
    @{ ID = "Git.Git"; Name = "Git" },
    @{ ID = "GitHub.cli"; Name = "GitHub CLI" },
    @{ ID = "Docker.DockerDesktop"; Name = "Docker Desktop" },
    @{ ID = "Microsoft.WSL"; Name = "WSL" },
    @{ ID = "CoreyButler.nvm-windows"; Name = "nvm (Node Version Manager)" },
    @{ ID = "Kirin70.pyenv-win"; Name = "pyenv-win" },
    @{ ID = "Google.Antigravity"; Name = "Antigravity AI" }
)

foreach ($app in $apps) {
    Write-Host "Verificando $($app.Name)..." -ForegroundColor Yellow
    $check = winget list --id $($app.ID) -e
    if ($null -eq $check -or $check.Count -eq 0) {
        Write-Host "Instalando $($app.Name)..." -ForegroundColor Green
        winget install --id $($app.ID) --silent --accept-package-agreements --accept-source-agreements
    }
    else {
        Write-Host "$($app.Name) já está instalado." -ForegroundColor Gray
    }
}

Write-Host "--- Configurações Finais ---" -ForegroundColor Cyan

# Configurar Git (Opcional - pode ser manual)
# git config --global user.name "Fabio Correa"
# git config --global user.email "seu-email@exemplo.com"

Write-Host "Tudo pronto! Reinicie o terminal para que as variáveis de ambiente tenham efeito." -ForegroundColor Green
