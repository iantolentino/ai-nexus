param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('feature-development', 'bug-fix', 'refactor', 'investigation')]
    [string]$Intent,
    [string[]]$Files = @(),
    [string]$ErrorContext,
    [switch]$NoManifest
)

$brainRoot = Split-Path -Parent $PSScriptRoot
$projectRoot = Split-Path -Parent $brainRoot
$selected = [System.Collections.Generic.List[System.IO.FileInfo]]::new()
$skipped = @('Unrelated daily logs', 'Archived handoffs', 'Legacy progress history', 'Unrelated architecture notes', 'Unrelated deployment history')

function Add-ContextFile([string]$path) {
    if ([string]::IsNullOrWhiteSpace($path)) { return }
    $candidates = @($path, (Join-Path $projectRoot $path), (Join-Path $brainRoot $path))
    $match = $candidates | Where-Object { Test-Path $_ -PathType Leaf } | Select-Object -First 1
    if (-not $match) { throw "Context file was not found: $path" }
    $item = Get-Item $match
    if (-not ($selected.FullName -contains $item.FullName)) { $selected.Add($item) }
}

@('AI_BRAIN.md', 'BRAIN_INDEX.md', 'CURRENT_STATE.md', 'sessions/LATEST_HANDOFF.md', "intents/$Intent.md") | ForEach-Object { Add-ContextFile $_ }
$today = Join-Path $brainRoot ('daily/' + (Get-Date -Format 'yyyy-MM-dd') + '.md')
if (Test-Path $today -PathType Leaf) { Add-ContextFile $today }
if ($ErrorContext) { Add-ContextFile $ErrorContext }
$Files | ForEach-Object { Add-ContextFile $_ }

$rows = foreach ($item in $selected) {
    $relative = if ($item.FullName.StartsWith($projectRoot, [System.StringComparison]::OrdinalIgnoreCase)) { $item.FullName.Substring($projectRoot.Length).TrimStart('\') } else { $item.FullName }
    [pscustomobject]@{ File = $relative; Lines = (Get-Content $item.FullName | Measure-Object -Line).Lines; Characters = $item.Length }
}

$totalLines = ($rows | Measure-Object -Property Lines -Sum).Sum
$totalCharacters = ($rows | Measure-Object -Property Characters -Sum).Sum
$timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss K'
$level = if ($Files.Count -gt 0 -or $ErrorContext) { '2 - Current Work' } else { '1 - Minimal' }
$output = @('# Context Selection', '', "- Generated: $timestamp", "- Intent: $Intent", "- Context level: $level", '', '## Load', '', '| File | Lines | Characters |', '| --- | ---: | ---: |')
$output += $rows | ForEach-Object { "| ``$($_.File)`` | $($_.Lines) | $($_.Characters) |" }
$output += @('', "Total: $($rows.Count) files, $totalLines lines, $totalCharacters characters.", '', '## Deliberately skipped', '')
$output += $skipped | ForEach-Object { "- $_" }
$output += @('', '## Expansion rule', '', 'Load a mapped architecture record, ADR, contract, or historical file only after identifying the exact missing information.')

$output -join [Environment]::NewLine | Write-Output

if (-not $NoManifest) {
    $manifestDirectory = Join-Path $brainRoot 'sessions/manifests'
    New-Item -ItemType Directory -Force -Path $manifestDirectory | Out-Null
    $manifestName = 'context-' + (Get-Date -Format 'yyyyMMdd-HHmmss') + '.md'
    $manifestPath = Join-Path $manifestDirectory $manifestName
    Set-Content -Path $manifestPath -Value $output -Encoding utf8
    Write-Output "`nManifest: sessions/manifests/$manifestName"
}
