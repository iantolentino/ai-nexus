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

## Developing AI Nexus itself

This repository uses the same minimal-context workflow. Codex reads the root `AGENTS.md`; Claude Code reads the root `CLAUDE.md`. Both use the `framework-maintenance` intent, which loads `FRAMEWORK_STATE.md` instead of template project state.

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

## Token-efficiency effect

AI Nexus saves context by controlling **what enters a session**, rather than claiming a provider-specific token quota.

| Without controlled context | With AI Nexus |
| --- | --- |
| Read a large controller, old progress, history, and unrelated folders | Read the universal controller, current state, latest handoff, intent profile, and only task-relevant files |
| Re-send unchanged project history each session | Carry forward a compact current state and handoff |
| Search broadly for a fact | Use `BRAIN_INDEX.md` to load its named source |
| Re-read old debugging attempts | Consult a compact fix index only when the symptom may match |
| Load every architecture note or daily log | Expand one context level only after identifying a specific missing fact |

For example, the selector's minimal code-review packet currently contains five framework files and reports its exact line and character totals. It deliberately skips unrelated daily logs, archived handoffs, legacy progress, unrelated architecture notes, and unrelated deployment history. Relevant source code, a diff, and an error log are added only for the task at hand.

This does **not** guarantee an exact number of tokens or a fixed subscription duration: providers count context differently and source files vary in size. AI Nexus measures deterministic proxies—files, lines, and characters—so you can see and reduce unnecessary context regardless of provider.

### Planning estimates by project stage

These are context-planning ranges, not provider guarantees. They assume a focused task and exclude the exact source code, diff, or error output needed to do that task.

| Project stage | Uncontrolled session context | AI Nexus selected context | Estimated reduction | Why it improves |
| --- | ---: | ---: | ---: | --- |
| MVP / early project | 8k–25k tokens | 1.5k–5k tokens | 60–85% | Avoids repeated specs, old discussion, and unrelated files |
| Growing project | 15k–50k tokens | 2k–8k tokens | 70–85% | Uses compact state/handoff instead of accumulating progress history |
| Production / multi-module project | 25k–100k+ tokens | 3k–12k tokens | 70–95% | Loads only the affected module, relevant decision/contract, and Git diff |

At the framework baseline, the minimal five-file packet is about 4,949 characters (roughly 1,250 tokens*) compared with the removed full-controller approach at about 20,671 characters (roughly 5,200 tokens*): about 76% less instruction context before task-specific source files are added.

\*Rough estimate using approximately four characters per token for English text. Code, languages, source-file size, and AI providers vary. Use the selector and metrics command for actual file, line, and character totals in a project.

Run the metrics command to inspect the current brain size:

```powershell
pwsh -NoProfile -File _brain/tools/context-metrics.ps1
```

## Git-aware continuation

For terminal agents, AI Nexus can load only what changed since the previous handoff.

Before stopping a session, generate a Git baseline and paste it into `sessions/LATEST_HANDOFF.md`:

```powershell
pwsh -NoProfile -File _brain/tools/handoff-baseline.ps1
```

At the next session, generate a diff from that baseline:

```powershell
pwsh -NoProfile -File _brain/tools/context-diff.ps1
```

The diff records the branch, current commit, changed files, staged/unstaged work, and untracked files. The selector includes `CONTEXT_DIFF.md` only when it contains a real current commit, so a placeholder never adds context.

```text
Previous handoff + Git context diff + affected source files
```

replaces rereading unchanged code or broad repository history.

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

Project-specific architecture, decisions, fixes, security, deployment, and release notes remain available as supporting knowledge. They are loaded only when the index identifies an exact need.

## Session continuity

At a meaningful milestone, update today's daily log and `CURRENT_STATE.md` when the project state changes. Before stopping, update `sessions/LATEST_HANDOFF.md` with the objective, completed work, decisions, blockers, relevant files, next action, and warnings.

## Maintenance

```powershell
pwsh -NoProfile -File _brain/tools/brain-doctor.ps1
pwsh -NoProfile -File _brain/tools/context-metrics.ps1
```

Brain Doctor checks active knowledge quality. Context Metrics reports deterministic file, line, and character totals without relying on provider-specific token accounting.

## License

Free to use and modify.
