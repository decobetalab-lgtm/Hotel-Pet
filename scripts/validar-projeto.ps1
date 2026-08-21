param(
    [string]$Pasta = "."
)

$Erro = 0
$Raiz = (Resolve-Path $Pasta).Path

Write-Host "========================================"
Write-Host "VALIDACAO - HOTEL PET"
Write-Host "========================================"

$Html = Get-ChildItem -Path $Raiz -Filter *.html -File -Recurse |
    Where-Object { $_.FullName -notmatch "\\\.git\\" }

$Css = Join-Path $Raiz "css\estilo.css"

if ($Html.Count -eq 0) {
    Write-Host "ERRO: nenhum arquivo HTML encontrado." -ForegroundColor Red
    $Erro++
}

if (-not (Test-Path $Css)) {
    Write-Host "ERRO: css\estilo.css não encontrado." -ForegroundColor Red
    $Erro++
} else {
    Write-Host "OK: arquivo CSS encontrado." -ForegroundColor Green
}

foreach ($Arquivo in $Html) {
    $Conteudo = Get-Content -Raw -Encoding UTF8 $Arquivo.FullName
    $Nome = $Arquivo.Name

    if ($Conteudo -notmatch "<!DOCTYPE html>") {
        Write-Host "ERRO: $Nome sem DOCTYPE." -ForegroundColor Red
        $Erro++
    }

    if ($Conteudo -notmatch '<html lang="pt-BR">') {
        Write-Host "AVISO: $Nome não informa lang=pt-BR." -ForegroundColor Yellow
    }

    if ($Conteudo -notmatch 'css/estilo\.css') {
        Write-Host "AVISO: $Nome não referencia css/estilo.css." -ForegroundColor Yellow
    }

    $Links = [regex]::Matches($Conteudo, '(?:href|src)="([^"]+)"')
    foreach ($Link in $Links) {
        $Destino = $Link.Groups[1].Value

        if ($Destino -match '^(https?://|#|mailto:|tel:|data:)') {
            continue
        }

        $Caminho = Join-Path $Arquivo.DirectoryName $Destino
        if (-not (Test-Path $Caminho)) {
            Write-Host "ERRO: $Nome aponta para arquivo inexistente: $Destino" -ForegroundColor Red
            $Erro++
        }
    }

    $Ids = [regex]::Matches($Conteudo, 'id="([^"]+)"') |
        ForEach-Object { $_.Groups[1].Value }

    $Duplicados = $Ids | Group-Object | Where-Object { $_.Count -gt 1 }
    foreach ($Duplicado in $Duplicados) {
        Write-Host "ERRO: $Nome possui id repetido: $($Duplicado.Name)" -ForegroundColor Red
        $Erro++
    }

    Write-Host "OK: $Nome" -ForegroundColor Green
}

Write-Host ""
if ($Erro -eq 0) {
    Write-Host "VALIDACAO CONCLUIDA: nenhum erro encontrado." -ForegroundColor Green
    exit 0
}

Write-Host "VALIDACAO CONCLUIDA COM $Erro ERRO(S)." -ForegroundColor Red
exit 1
