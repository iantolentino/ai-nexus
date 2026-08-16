param(
    [int]$MaxActiveFileLines = 250,
    [int]$StaleDays = 9
)

$brainRoot = Split-Path -Parent $PSScriptRoot
$warnings = [System.Collections.Generic.List[string]]::new()
$required = @('AI_BRAIN.md', 'BRAIN_INDEX.md', 'CURRENT_STATE.md', 'CONTINUE_PROMPT.md', 'sessions/LATEST_HANDOFF.md')

foreach ($relativePath in $required) {
    if (-not (Test-Path (Join-Path $brainRoot $relativePath))) { $warnings.Add("Missing required active file: $relativePath") }
}

$currentState = Join-Path $brainRoot 'CURRENT_STATE.md'
if (Test-Path $currentState) {
    $age = (New-TimeSpan -Start (Get-Item $currentState).LastWriteTime -End (Get-Date)).Days
    if ($age -ge $StaleDays) { $warnings.Add("CURRENT_STATE.md has not been updated in $age days") }
}

$activeFiles = @(
    Get-ChildItem $brainRoot -File | Where-Object { $_.Name -in @('AI_BRAIN.md', 'BRAIN_INDEX.md', 'CURRENT_STATE.md', 'CONTINUE_PROMPT.md') }
    Get-ChildItem $brainRoot -File -Recurse -Path (Join-Path $brainRoot 'daily'), (Join-Path $brainRoot 'sessions'), (Join-Path $brainRoot 'architecture'), (Join-Path $brainRoot 'decisions'), (Join-Path $brainRoot 'intents') -ErrorAction SilentlyContinue |
        Where-Object { $_.FullName -notmatch '\\archive\\' }
)

$activeFiles | ForEach-Object {
    $lineCount = (Get-Content $_.FullName | Measure-Object -Line).Lines
    if ($lineCount -gt $MaxActiveFileLines) { $warnings.Add("Active file exceeds $MaxActiveFileLines lines: $($_.FullName.Substring($brainRoot.Length + 1)) ($lineCount)") }
}

$index = Join-Path $brainRoot 'BRAIN_INDEX.md'
if (Test-Path $index) {
    [regex]::Matches((Get-Content $index -Raw), '`([^`]+\.md)`') | ForEach-Object {
        $relativePath = $_.Groups[1].Value
        if ($relativePath -notmatch '<|YYYY|\*') {
            $candidate = Join-Path $brainRoot $relativePath
            if (-not (Test-Path $candidate)) { $warnings.Add("Broken index reference: $relativePath") }
        }
    }
}

$score = [Math]::Max(0, 100 - ($warnings.Count * 8))
Write-Output "Brain Health: $score%"
if ($warnings.Count -eq 0) { Write-Output 'No warnings.' } else { $warnings | ForEach-Object { Write-Output "Warning: $_" } }
