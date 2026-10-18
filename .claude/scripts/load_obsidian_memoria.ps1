$ErrorActionPreference = "SilentlyContinue"

# Ler VAULT_MEMORIA do ~/.claude/CLAUDE.md ou usar padrao
$globalClaudeMd = "$HOME\.claude\CLAUDE.md"
$vaultClaude = "C:\Users\Marcos\Documents\Marcos-Obsidian\Marcos Miranda\Claude"

if (Test-Path $globalClaudeMd) {
    $content = Get-Content $globalClaudeMd -Raw
    if ($content -match 'VAULT_MEMORIA\s*=\s*(.*)') {
        $vaultClaude = $Matches[1].Trim()
    }
}

$projectName = Split-Path (Get-Location) -Leaf
$projectVault = Join-Path $vaultClaude $projectName

$output = ""

# 1. ESTADO.md
$estadoPath = Join-Path $projectVault "ESTADO.md"
if (Test-Path $estadoPath) {
    $output += "=== ESTADO ATUAL ($projectName) ===`n" + (Get-Content $estadoPath -Raw) + "`n`n"
}

# 2. RECADOS.md
$recadosPath = Join-Path $projectVault "RECADOS.md"
if (Test-Path $recadosPath) {
    $output += "=== RECADOS PENDENTES ===`n" + (Get-Content $recadosPath -Raw) + "`n`n"
}

# 3. SESSOES-ATIVAS.md
$sessoesPath = Join-Path $projectVault "SESSOES-ATIVAS.md"
if (Test-Path $sessoesPath) {
    $output += "=== SESSOES ATIVAS ===`n" + (Get-Content $sessoesPath -Raw) + "`n`n"
}

# 4. Ultimas 15 linhas do INDICE.md global
$indiceGlobal = Join-Path $vaultClaude "INDICE.md"
if (Test-Path $indiceGlobal) {
    $linhasIndice = Get-Content $indiceGlobal | Select-Object -Last 15
    $output += "=== INDICE GLOBAL (ULTIMAS 15 LINHAS) ===`n" + ($linhasIndice -join "`n") + "`n"
}

# Limite de 6000 caracteres
if ($output.Length -gt 6000) {
    $output = $output.Substring(0, 6000)
}

Write-Output $output
