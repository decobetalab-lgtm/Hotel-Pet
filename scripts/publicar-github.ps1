param(
    [string]$Repositorio = "",
    [string]$Nome = "",
    [string]$Email = "",
    [string]$ContaGithub = "",
    [switch]$Enviar
)

$ErrorActionPreference = "Stop"

Write-Host "========================================"
Write-Host "PUBLICACAO DO HOTEL PET"
Write-Host "========================================"

git rev-parse --is-inside-work-tree | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERRO: esta pasta não é um repositorio Git." -ForegroundColor Red
    exit 1
}

$NomeAtual = git config user.name
$EmailAtual = git config user.email

if ([string]::IsNullOrWhiteSpace($Nome)) {
    $Nome = Read-Host "Nome para os próximos commits [$NomeAtual]"
    if ([string]::IsNullOrWhiteSpace($Nome)) { $Nome = $NomeAtual }
}

if ([string]::IsNullOrWhiteSpace($Email)) {
    $Email = Read-Host "E-mail do GitHub [$EmailAtual]"
    if ([string]::IsNullOrWhiteSpace($Email)) { $Email = $EmailAtual }
}

if ([string]::IsNullOrWhiteSpace($Nome) -or [string]::IsNullOrWhiteSpace($Email)) {
    Write-Host "ERRO: informe nome e e-mail do commit." -ForegroundColor Red
    exit 1
}

git config user.name $Nome
git config user.email $Email

if (-not [string]::IsNullOrWhiteSpace($ContaGithub)) {
    if (Get-Command gh -ErrorAction SilentlyContinue) {
        Write-Host "Selecionando conta GitHub: $ContaGithub"
        gh auth switch --user $ContaGithub
        if ($LASTEXITCODE -ne 0) {
            Write-Host "AVISO: não foi possível trocar a conta pelo GitHub CLI." -ForegroundColor Yellow
        }
    } else {
        Write-Host "AVISO: GitHub CLI não está instalado. A autenticação será feita pelo Git/Windows." -ForegroundColor Yellow
    }
}

if (-not [string]::IsNullOrWhiteSpace($Repositorio)) {
    git remote set-url origin $Repositorio
}

Write-Host ""
Write-Host "Remoto atual:"
git remote -v

if (Test-Path ".\scripts\validar-projeto.ps1") {
    & ".\scripts\validar-projeto.ps1"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERRO: corrija a validação antes de publicar." -ForegroundColor Red
        exit 1
    }
}

$Pendentes = @(
    git diff --name-only
    git ls-files --others --exclude-standard
) | Where-Object { $_ -and $_.Trim() -ne "" } |
    Sort-Object -Unique

# Ordem simples para acompanhar a sequência da atividade.
$Ordem = @(
    "configuracoes.html",
    "index.html",
    "login.html",
    "perfil.html",
    "pet_cadastrar.html",
    "pet_editar.html",
    "pet_visualizar.html",
    "pets.html",
    "reserva_cadastrar.html",
    "reserva_editar.html",
    "reserva_visualizar.html",
    "reservas.html",
    "usuario_cadastrar.html",
    "usuario_editar.html",
    "usuario_visualizar.html",
    "usuarios.html",
    "css/estilo.css",
    "README.md",
    ".gitignore",
    "manifesto_sha256.txt",
    "scripts/validar-projeto.ps1",
    "scripts/publicar-github.ps1",
    "PLANO_COMMITS.md",
    ".github/workflows/deploy.yml"
)

$Arquivos = @()
foreach ($Item in $Ordem) {
    if ($Pendentes -contains $Item) {
        $Arquivos += $Item
    }
}

# Inclui qualquer arquivo novo que não esteja na ordem acima.
foreach ($Item in $Pendentes) {
    if ($Arquivos -notcontains $Item) {
        $Arquivos += $Item
    }
}

if ($Arquivos.Count -eq 0) {
    Write-Host "Nenhum arquivo novo ou modificado para commit." -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "Arquivos que serão registrados individualmente:"
$Arquivos | ForEach-Object { Write-Host " - $_" }

$Confirmacao = Read-Host "Continuar? (S/N)"
if ($Confirmacao -notmatch '^[Ss]$') {
    Write-Host "Operação cancelada."
    exit 0
}

foreach ($Arquivo in $Arquivos) {
    Write-Host ""
    Write-Host "----------------------------------------"
    Write-Host "Registrando: $Arquivo"
    Write-Host "----------------------------------------"

    git add -- "$Arquivo"

    git diff --cached --quiet
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Sem alteração pendente: $Arquivo" -ForegroundColor Yellow
        continue
    }

    $Mensagens = @{
        "configuracoes.html" = "Ajusta página de configurações"
        "index.html" = "Organiza página inicial"
        "login.html" = "Organiza página de login"
        "perfil.html" = "Organiza página de perfil"
        "pet_cadastrar.html" = "Organiza cadastro de pet"
        "pet_editar.html" = "Organiza edição de pet"
        "pet_visualizar.html" = "Organiza visualização de pet"
        "pets.html" = "Organiza página de pets"
        "reserva_cadastrar.html" = "Organiza cadastro de reserva"
        "reserva_editar.html" = "Organiza edição de reserva"
        "reserva_visualizar.html" = "Organiza visualização de reserva"
        "reservas.html" = "Organiza página de reservas"
        "usuario_cadastrar.html" = "Organiza cadastro de usuário"
        "usuario_editar.html" = "Organiza edição de usuário"
        "usuario_visualizar.html" = "Organiza visualização de usuário"
        "usuarios.html" = "Organiza página de usuários"
        "css/estilo.css" = "Adiciona folha de estilos"
        "README.md" = "Atualiza documentação do projeto"
        ".gitignore" = "Adiciona arquivos ignorados"
        "manifesto_sha256.txt" = "Atualiza manifesto SHA256"
        "scripts/validar-projeto.ps1" = "Adiciona validação do projeto"
        "scripts/publicar-github.ps1" = "Adiciona script de publicação"
        "PLANO_COMMITS.md" = "Documenta plano de commits"
        ".github/workflows/deploy.yml" = "Adiciona deploy do GitHub Pages"
    }

    $Mensagem = $Mensagens[$Arquivo]
    if ([string]::IsNullOrWhiteSpace($Mensagem)) {
        $Base = [System.IO.Path]::GetFileNameWithoutExtension($Arquivo)
        $Mensagem = "Atualiza $Base"
    }

    git commit -m $Mensagem
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERRO no commit de $Arquivo." -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "Histórico recente:"
git --no-pager log -10 --oneline

if ($Enviar) {
    Write-Host ""
    Write-Host "Enviando branch main para o GitHub..."
    git push -u origin main

    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERRO no push. O histórico local continua preservado." -ForegroundColor Red
        exit 1
    }

    Write-Host "Push concluído." -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "Commits locais concluídos. Para enviar manualmente:"
    Write-Host "git push -u origin main"
}
