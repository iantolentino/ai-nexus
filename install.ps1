# AI Nexus — installer / updater (PowerShell, Windows/Mac/Linux with pwsh).
#
# Run from your project's root directory:
#   irm https://raw.githubusercontent.com/iantolentino/ai-nexus/main/install.ps1 | iex
# or download this file into your project root and run: .\install.ps1
#
# - If _brain/ does not exist yet: installs it fresh.
# - If _brain/ already exists: updates framework files only, never touches project data.
#   See _brain/templates/update_rules.md for the exact split.
# - Also drops root-level pointer files (CLAUDE.md, AGENTS.md, .cursorrules, .windsurfrules,
#   .github/copilot-instructions.md) so any AI tool auto-loads instructions to read
#   _brain/claude.md first — only where none already exists.

$Repo = "https://github.com/iantolentino/ai-nexus.git"
$Target = "_brain"
$TmpDir = Join-Path $env:TEMP ("ai-nexus-" + [guid]::NewGuid().ToString())

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "git is required and was not found on PATH."
    exit 1
}

try {
    Write-Host "AI Nexus installer"
    Write-Host "Cloning framework..."
    # Do not redirect git's stderr here: PowerShell 5.1 wraps each stderr line (git writes its
    # normal clone progress to stderr) as a NativeCommandError, which is harmless unless a
    # global ErrorActionPreference of "Stop" is set — so this script deliberately never sets
    # that and checks $LASTEXITCODE instead.
    git clone --depth 1 $Repo $TmpDir 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "git clone failed with exit code $LASTEXITCODE. Check your network connection."
    }

    if (Test-Path $Target) {
        Write-Host "_brain/ already exists - updating framework files only (project data untouched)."
        $FrameworkPaths = @(
            "claude.md", "aibrain.md", "INDEX.md", "overview", "prompts", "governance", "interaction",
            "tasks/task_rules.md", "tasks/task_templates.md", "templates",
            "fixes/README.md", "fixes/_template.md", "quick-ref/README.md"
        )
        foreach ($path in $FrameworkPaths) {
            $src = Join-Path $TmpDir "_brain/$path"
            $dest = Join-Path $Target $path
            if (Test-Path $src -PathType Container) {
                # Copy CONTENTS into an existing dest, not the folder itself — Copy-Item with an
                # already-existing destination container nests the source folder inside it
                # instead of merging/overwriting in place.
                if (-not (Test-Path $dest)) {
                    New-Item -ItemType Directory -Force -Path $dest -ErrorAction Stop | Out-Null
                }
                Copy-Item -Path (Join-Path $src "*") -Destination $dest -Recurse -Force -ErrorAction Stop
                Write-Host "  updated: $path/"
            } elseif (Test-Path $src) {
                $destDir = Split-Path $dest -Parent
                if ($destDir -and -not (Test-Path $destDir)) {
                    New-Item -ItemType Directory -Force -Path $destDir -ErrorAction Stop | Out-Null
                }
                Copy-Item -Path $src -Destination $dest -Force -ErrorAction Stop
                Write-Host "  updated: $path"
            }
        }
    } else {
        Write-Host "Installing fresh _brain/ ..."
        Copy-Item -Path (Join-Path $TmpDir "_brain") -Destination $Target -Recurse -Force -ErrorAction Stop
    }

    Write-Host "Installing AI-tool entry points (only where none already exist)..."
    $EntrySrcNames  = @("CLAUDE.md", "AGENTS.md", ".cursorrules", ".windsurfrules", "copilot-instructions.md")
    $EntryDestPaths = @("CLAUDE.md", "AGENTS.md", ".cursorrules", ".windsurfrules", ".github/copilot-instructions.md")
    $EntrySrcDir = Join-Path $TmpDir "_brain/templates/entrypoints"

    for ($i = 0; $i -lt $EntrySrcNames.Length; $i++) {
        $srcName = $EntrySrcNames[$i]
        $destPath = $EntryDestPaths[$i]
        if (Test-Path $destPath) {
            Write-Host "  skipped $destPath (already exists) - add this line manually: `"Read _brain/claude.md in full before doing anything else.`""
        } else {
            $destDir = Split-Path $destPath -Parent
            if ($destDir -and -not (Test-Path $destDir)) {
                New-Item -ItemType Directory -Force -Path $destDir -ErrorAction Stop | Out-Null
            }
            Copy-Item -Path (Join-Path $EntrySrcDir $srcName) -Destination $destPath -Force -ErrorAction Stop
            Write-Host "  created: $destPath"
        }
    }

    Write-Host ""
    Write-Host "Done. _brain/ is ready."
    Write-Host "Next: paste _brain/prompts/bootstrap_prompt.md into a new AI chat session to start."
}
finally {
    if (Test-Path $TmpDir) {
        Remove-Item -Path $TmpDir -Recurse -Force
    }
}
