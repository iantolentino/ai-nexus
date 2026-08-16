$brainRoot = Split-Path -Parent $PSScriptRoot
$projectRoot = Split-Path -Parent $brainRoot

function Invoke-Git([string[]]$Arguments) {
    $result = & git -C $projectRoot @Arguments 2>$null
    if ($LASTEXITCODE -ne 0) { throw "Git command failed: git $($Arguments -join ' ')" }
    return $result
}

$commit = (Invoke-Git @('rev-parse', 'HEAD')).Trim()
$branch = (Invoke-Git @('branch', '--show-current')).Trim()
$status = @(Invoke-Git @('status', '--short'))
$workingTree = if ($status.Count -eq 0) { 'clean' } else { 'has uncommitted changes' }

@(
    '## Git Baseline'
    ''
    "- Base commit: $commit"
    "- Branch: $branch"
    "- Working tree at handoff: $workingTree"
    '- Verification: [tests/checks run, or not yet run]'
) -join [Environment]::NewLine | Write-Output
