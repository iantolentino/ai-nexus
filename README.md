# AI Nexus

AI Nexus is a provider-neutral context-management framework for AI-assisted software development. It helps developers work with Codex, Claude Code, Cursor, Windsurf, Copilot, and compatible agents without repeatedly loading a full project history.

## Core principle

> The best context is not the most context. It is the smallest context that allows the task to be completed correctly.

AI Nexus keeps active project knowledge compact, preserves durable decisions, and expands context only when a task requires it.

`_brain/AI_BRAIN.md` is the single universal controller. Every provider adapter points to it; `AGENTS.md`, `CLAUDE.md`, and other tool-specific files are not separate sources of truth.

## Install

Run one installer from a project's root directory:

```powershell
# Windows PowerShell, or pwsh on macOS/Linux
irm https://raw.githubusercontent.com/iantolentino/ai-nexus/main/install.ps1 | iex
```

```bash
# macOS, Linux, WSL, or Git Bash
curl -fsSL https://raw.githubusercontent.com/iantolentino/ai-nexus/main/install.sh | bash
```

The installer creates `_brain/`. On updates it preserves project knowledge and refreshes framework files. It also creates provider entry instructions only when a matching file does not already exist.

## Automatic start

Open a supported coding agent from the project root and state the task normally:

```text
Fix the login redirect loop after sign-in.
```

No repeated startup prompt is required when the root instruction file exists.

| Tool | Automatic entry file |
| --- | --- |
| Codex | `AGENTS.md` |
| Claude Code | `CLAUDE.md` |
| Cursor | `.cursorrules` |
| Windsurf | `.windsurfrules` |
| GitHub Copilot | `.github/copilot-instructions.md` |

Those files are deliberately small adapters. They direct the agent to the universal controller, `_brain/AI_BRAIN.md`, then to the context selector. They are not separate controllers and never require a full legacy brain read.

For browser ChatGPT, browser Claude, or any tool that cannot read local project files automatically, paste `_brain/CONTINUE_PROMPT.md` into the chat first, then state the task.

To explicitly verify the workflow in any supported agent, use:

```text
Use AI Nexus for this task. Identify the intent, run the context selector, read only its selected files, then proceed.

Task: [describe the work]
```

## How context selection works

For a task, AI Nexus selects:

1. `AI_BRAIN.md` — operating policy
2. `BRAIN_INDEX.md` — question-to-source map
3. `CURRENT_STATE.md` — active project state
4. `sessions/LATEST_HANDOFF.md` — previous-session continuation state
5. An intent profile and only the exact code, error, specification, or supporting record required

Run the selector manually when desired:

```powershell
pwsh -NoProfile -File _brain/tools/select-context.ps1 -Intent bug-fix -Files src/auth/login.ts -ErrorContext logs/login-error.txt
```

It reports the selected files, line and character totals, deliberately skipped knowledge, and can save a session manifest. Use `-NoManifest` for a read-only preview.

## Brain layout

```text
_brain/
├── AI_BRAIN.md             # Context policy
├── BRAIN_INDEX.md          # Question -> knowledge -> source map
├── CURRENT_STATE.md        # Compact active state
├── CONTINUE_PROMPT.md      # Browser-chat continuation prompt
├── daily/                  # One activity log per day
├── sessions/               # Latest handoff, checkpoints, manifests, archive
├── architecture/           # Stable architecture knowledge
├── decisions/              # ADRs and durable decisions
├── intents/                # Context profiles by task type
├── tools/                  # Selector, Brain Doctor, metrics
└── archive/                # Historical knowledge
```

Legacy folders such as `progress/`, `memory/`, and `summaries/` remain available for existing projects. They are supporting or historical context unless the index identifies an exact need.

## Session continuity

At a meaningful milestone, update today's daily log and `CURRENT_STATE.md` when the project state changes. Before stopping, update `sessions/LATEST_HANDOFF.md` with the objective, completed work, decisions, blockers, relevant files, next action, and warnings.

## Maintenance

```powershell
pwsh -NoProfile -File _brain/tools/brain-doctor.ps1
pwsh -NoProfile -File _brain/tools/context-metrics.ps1
```

Brain Doctor checks active knowledge quality. Context Metrics reports deterministic file, line, and character totals without relying on provider-specific token accounting.

## Legacy controller

`_brain/claude.md` is preserved for projects that intentionally use the original four-state controller. It is not the default or required entry point for provider-neutral AI Nexus usage.

## License

Free to use and modify.
