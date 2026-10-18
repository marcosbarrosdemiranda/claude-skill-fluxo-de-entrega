$ErrorActionPreference = "SilentlyContinue"

$projectRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$memoriaDir = Join-Path $projectRoot ".claude\memoria"
$globalMemoriaDir = "$HOME\.claude\memoria-global"
$indicePath = Join-Path $memoriaDir "INDICE.md"
$globalIndicePath = Join-Path $globalMemoriaDir "INDICE.md"
$recadosPath = Join-Path $memoriaDir "RECADOS.md"
$sessoesAtivasPath = Join-Path $memoriaDir "SESSOES-ATIVAS.md"

# 1. Registrar sessao atual em SESSOES-ATIVAS.md
if (-not (Test-Path $memoriaDir)) { New-Item -ItemType Directory -Force $memoriaDir | Out-Null }
$sessionId = Get-Random -Minimum 1000 -Maximum 9999
$horaInicio = Get-Date -Format "HH:mm"
$novaSessao = "- ID: $sessionId | Inicio: $horaInicio | Tarefa: Sessao ativa inicializada"

$sessoes = @()
if (Test-Path $sessoesAtivasPath) {
    $linhas = Get-Content $sessoesAtivasPath
    foreach ($linha in $linhas) {
        if ($linha -match 'Inicio: (\d{2}:\d{2})') {
            $tempoInicio = [datetime]::ParseExact($Matches[1], 'HH:mm', $null)
            $agora = Get-Date
            # Se for do mesmo dia e menos de 2 horas
            if (($agora - $tempoInicio).TotalHours -le 2) {
                $sessoes += $linha
            }
        }
    }
}
$sessoes += $novaSessao
Set-Content -Path $sessoesAtivasPath -Value $sessoes -Encoding utf8

# 2. Exibir Indice de Memoria do Projeto
Write-Output "=== INDICE DE MEMORIA DO PROJETO ==="
if (Test-Path $indicePath) { Get-Content $indicePath -Raw } else { Write-Output "Nenhum INDICE.md no projeto." }

# 3. Exibir ultimos 3 dias de memoria global
Write-Output "`n=== MEMORIA GLOBAL (ULTIMOS 3 DIAS) ==="
if (Test-Path $globalMemoriaDir) {
    $globalFiles = Get-ChildItem -Path $globalMemoriaDir -Filter "*.md" | Where-Object { $_.Name -ne "INDICE.md" } | Sort-Object Name -Descending | Select-Object -First 3
    foreach ($file in $globalFiles) {
        Write-Output "`n--- Global: $($file.Name) ---"
        Get-Content $file.FullName -Raw
    }
} else {
    Write-Output "Nenhuma memoria global encontrada."
}

# 4. Exibir Recados Pendentes
Write-Output "`n=== RECADOS PENDENTES ==="
if (Test-Path $recadosPath) {
    Get-Content $recadosPath -Raw
} else {
    Write-Output "Nenhum recado pendente."
}

# 5. Exibir Sessoes Ativas
Write-Output "`n=== SESSOES ATIVAS ==="
if (Test-Path $sessoesAtivasPath) {
    Get-Content $sessoesAtivasPath -Raw
}
