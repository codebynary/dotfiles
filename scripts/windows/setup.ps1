# setup.ps1 - Dotfiles Evolution v2.1
# By: CodeBy.Dev
# Execute como Administrador

# Forçar UTF8 para saída do console
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Stop"

function Install-Winget {
    Write-Host "[*] Iniciando Bootstrap do Winget..." -ForegroundColor Cyan
    $tempDir = Join-Path $env:TEMP "WingetInstall"
    if (!(Test-Path $tempDir)) { New-Item -ItemType Directory -Path $tempDir | Out-Null }

    try {
        Write-Host "    -> Buscando versao mais recente no GitHub..." -ForegroundColor Gray
        $release = Invoke-RestMethod -Uri "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
        $asset = $release.assets | Where-Object { $_.name -like "*msixbundle" } | Select-Object -First 1
        
        if ($asset) {
            $downloadUrl = $asset.browser_download_url
            $destFile = Join-Path $tempDir $asset.name
            
            Write-Host "    -> Baixando $($asset.name)..." -ForegroundColor Gray
            Invoke-WebRequest -Uri $downloadUrl -OutFile $destFile
            
            Write-Host "    -> Instalando pacote..." -ForegroundColor Gray
            Add-AppxPackage -Path $destFile
            Write-Host "    -> Winget instalado com sucesso!" -ForegroundColor Green
            return $true
        }
    }
    catch {
        Write-Host "    -> Erro ao automatizar instalacao: $($_.Exception.Message)" -ForegroundColor Red
    }
    return $false
}

function Test-Winget {
    if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "[!] Winget nao detectado no PATH. Tentando auto-correcao..." -ForegroundColor Yellow
        $wingetPath = "$env:LOCALAPPDATA\Microsoft\WindowsApps\winget.exe"
        if (Test-Path $wingetPath) {
            $pathDir = "$env:LOCALAPPDATA\Microsoft\WindowsApps"
            $env:PATH = "$env:PATH;$pathDir"
            Write-Host "    -> Caminho temporario adicionado para esta sessao." -ForegroundColor Gray
        }
        else {
            Write-Host "    -> Winget nao encontrado no sistema." -ForegroundColor DarkYellow
            $confirm = Read-Host "    Deseja que eu tente BAIXAR e INSTALAR o Winget agora? (S/N)"
            if ($confirm -eq 'S') {
                return (Install-Winget)
            }
            return $false
        }
    }
    return $true
}

if (!(Test-Winget)) { exit }

function Show-Header {
    Clear-Host
    # Usando caracteres ASCII padrão para compatibilidade total
    Write-Host @"
------------------------------------------------------------
  ####  ####  ####  ##### ####  #   #    ####  ##### #   #
 #     #    # #   # #     #   #  # #     #   # #     #   #
 #     #    # #   # ####  ####    #      #   # ####   # # 
 #     #    # #   # #     #   #   #      #   # #      # # 
  ####  ####  ####  ##### ####    #      ####  #####   #  

            >>> Dotfiles // Environment Setup <<<           
------------------------------------------------------------
"@ -ForegroundColor Cyan

    Write-Host "`n  [+] Stack de Desenvolvimento Automatizada" -ForegroundColor Gray
    Write-Host "  [+] Pronto para configurar seu ambiente`n" -ForegroundColor DarkGray
}

$apps = @(
    [PSCustomObject]@{ ID = "Git.Git"; Name = "Git"; Category = "Core" },
    [PSCustomObject]@{ ID = "GitHub.cli"; Name = "GitHub CLI"; Category = "Core" },
    [PSCustomObject]@{ ID = "Docker.DockerDesktop"; Name = "Docker Desktop"; Category = "Virtualizacao" },
    [PSCustomObject]@{ ID = "Microsoft.WSL"; Name = "WSL 2"; Category = "Virtualizacao" },
    [PSCustomObject]@{ ID = "CoreyButler.nvm-windows"; Name = "Node.js (NVM)"; Category = "Linguagens" },
    [PSCustomObject]@{ ID = "Kirin70.pyenv-win"; Name = "Python (Pyenv)"; Category = "Linguagens" },
    [PSCustomObject]@{ ID = "Microsoft.VisualStudioCode"; Name = "VS Code"; Category = "Editores" },
    [PSCustomObject]@{ ID = "Anysphere.Cursor"; Name = "Cursor AI"; Category = "Editores" },
    [PSCustomObject]@{ ID = "Brave.Brave"; Name = "Brave Browser"; Category = "Browsers" },
    [PSCustomObject]@{ ID = "Postman.Postman"; Name = "Postman"; Category = "Dev Tools" },
    [PSCustomObject]@{ ID = "dbeaver.dbeaver"; Name = "DBeaver"; Category = "Dev Tools" },
    [PSCustomObject]@{ ID = "Discord.Discord"; Name = "Discord"; Category = "Comunicacao" },
    [PSCustomObject]@{ ID = "Google.Antigravity"; Name = "Antigravity AI"; Category = "AI" }
)

function Show-Menu {
    Write-Host "Selecione as ferramentas para instalar (Ex: 1,2,5 ou 'A'):" -ForegroundColor Yellow
    for ($i = 0; $i -lt $apps.Count; $i++) {
        Write-Host "  $($i + 1). [$($apps[$i].Category)] $($apps[$i].Name)"
    }
    Write-Host "`n  A. Instalar TUDO"
    Write-Host "  Q. Sair`n"
}

Show-Header
Show-Menu

$selection = Read-Host "Opcao"
$targets = @()

if ($selection -eq 'A' -or $selection -eq 'all') {
    $targets = $apps
}
elseif ($selection -eq 'Q') {
    exit
}
else {
    $indices = $selection -split ','
    foreach ($idx in $indices) {
        if ([int]::TryParse($idx.Trim(), [ref]$num)) {
            $num--
            if ($num -ge 0 -and $num -lt $apps.Count) {
                $targets += $apps[$num]
            }
        }
    }
}

if ($targets.Count -eq 0) {
    Write-Host "Nenhuma selecao valida. Saindo..." -ForegroundColor Red
    exit
}

# Inicio da Instalacao
$logFile = "install_log.txt"
"### Log de Instalacao - $(Get-Date) ###" | Out-File $logFile -Encoding UTF8

foreach ($app in $targets) {
    Write-Host "`n[+] Instalando $($app.Name)..." -ForegroundColor Cyan
    try {
        winget install --id $($app.ID) --silent --accept-package-agreements --accept-source-agreements
        "$($app.Name): SUCESSO" | Out-File $logFile -Append -Encoding UTF8
        Write-Host "    Concluido!" -ForegroundColor Green
    }
    catch {
        "$($app.Name): FALHA - $($_.Exception.Message)" | Out-File $logFile -Append -Encoding UTF8
        Write-Host "    Erro na instalacao." -ForegroundColor Red
    }
}

# Verificacao de Perfil
$profileName = $env:USERNAME
$userProfilePath = "..\..\profiles\$profileName"

if (Test-Path $userProfilePath) {
    Write-Host "`n[!] Perfil localizado para $profileName. Aplicando customizacoes..." -ForegroundColor Magenta
    $gitConfigSrc = Join-Path $userProfilePath ".gitconfig"
    $gitConfigDest = Join-Path $env:USERPROFILE ".gitconfig"
    if (Test-Path $gitConfigSrc) {
        Write-Host "    -> Atualizando .gitconfig..." -ForegroundColor Gray
        Copy-Item -Path $gitConfigSrc -Destination $gitConfigDest -Force
        "Profile: .gitconfig atualizado" | Out-File $logFile -Append -Encoding UTF8
    }
}
else {
    Write-Host "`n[i] Nenhum perfil pessoal localizado em $userProfilePath." -ForegroundColor Gray
}

Write-Host "`n--- Script Finalizado! ---" -ForegroundColor Green
Write-Host "Verifique o log em: $logFile" -ForegroundColor Gray
Write-Host "CodeBy.Dev // 2026" -ForegroundColor DarkCyan
