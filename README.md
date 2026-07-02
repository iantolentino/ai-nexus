# AI Nexus — AI Project Control System

AI Nexus is a **state-driven control framework** for AI-assisted software development.

It does not contain application code. It contains the **governance system that tells an AI how to plan, structure, and build a project** — enforcing deterministic behavior, preventing runaway token usage, and guaranteeing complete outputs.

---

## Why This Exists

Most AI-assisted projects break down because:

- The AI makes assumptions about requirements
- Planning and coding get mixed in the same session
- Context bloat causes the AI to lose track of prior decisions
- Outputs are partial, inconsistent, or unrepeatable

AI Nexus fixes this with a strict **4-state execution model** and a memory system that keeps context minimal and controlled.

---

## How It Works

All AI behavior is governed by `_brain/claude.md` (the brain controller).

The AI moves through four states in order. No state can be skipped.

| State | Name | What Happens |
|---|---|---|
| 1 | BOOTSTRAP_MODE | AI collects project specs. No files written. No code. |
| 2 | CONFIRMATION_LOCK | AI presents plan. Waits for your approval. |
| 3 | SYSTEM_GENERATION | AI writes the full `_brain/` structure. No code yet. |
| 4 | EXECUTION_MODE | AI executes one task at a time. Updates memory. Stops. |

---

## Quick Start

### Step 1 — Add AI Nexus to your project

Open a terminal in your project's root folder and run whichever fits your platform:

```bash
# Mac / Linux / WSL / Git Bash
curl -fsSL https://raw.githubusercontent.com/iantolentino/ai-nexus/main/install.sh | bash
```

```powershell
# Windows PowerShell (or pwsh on Mac/Linux)
irm https://raw.githubusercontent.com/iantolentino/ai-nexus/main/install.ps1 | iex
```

```bat
:: Windows cmd.exe — download setup.bat into your project root first, then:
setup.bat
```

All three do the same thing and are safe to re-run any time:

> 1. Clone the AI Nexus repository into a temp folder
> 2. If `_brain/` doesn't exist yet → install it fresh
> 3. If `_brain/` already exists → update framework files only (`claude.md`, `prompts/`,
>    `governance/`, etc.) and **never touch your project data** (`memory/`, `progress/`,
>    `fixes/fix_log.md`, `decisions/`, ...) — see `_brain/templates/update_rules.md`
> 4. Drop root-level pointer files (`CLAUDE.md`, `AGENTS.md`, `.cursorrules`, `.windsurfrules`,
>    `.github/copilot-instructions.md`) — only where none already exist — so that **whichever AI
>    tool you use, it auto-loads instructions to read `_brain/claude.md` first**, before scanning
>    anything else. This is the main token-saving mechanism: one small file read up front instead
>    of a full repo scan every session.
> 5. Clean up and confirm completion

---

### Step 2 — Start a new project with AI

Open a new AI chat session (Claude, ChatGPT, or any LLM).

Copy and paste the contents of `_brain/prompts/bootstrap_prompt.md` into the chat.

The AI will enter BOOTSTRAP_MODE and ask you 8 questions about your project. Answer them.

---

### Step 3 — Review and approve the plan

After you answer the questions, the AI moves to CONFIRMATION_LOCK.

It will present:
- A feature classification (what to build now, defer, or reject)
- A dependency map
- A high-level architecture

Reply with **confirm**, **approved**, or **proceed** to continue.

The AI will then generate the full `_brain/` planning structure for your project (SYSTEM_GENERATION).

---

### Step 4 — Build, one task at a time

For every new session where you want to continue building:

Copy and paste the contents of `_brain/prompts/continue_prompt.md` into a new chat.

The AI will:
1. Read `_brain/progress/progress.md` and `_brain/summaries/current_state.md`
2. Select the next incomplete task
3. Execute it fully
4. Update the memory files
5. Stop

Repeat this for each session.

---

### Debugging

If something breaks, copy and paste the contents of `_brain/prompts/debug_prompt.md` into a chat, then describe the problem.

The AI will first check `_brain/fixes/fix_log.md` for a matching prior fix — if this exact bug (or
one like it) was already solved in a past session, the AI reuses that root cause instead of
re-diagnosing from scratch. Then it fixes only what is broken — no refactoring, no feature
additions — and logs the fix back to `fixes/fix_log.md` before stopping, so the next session (or
the next AI tool entirely) doesn't repeat the investigation.

---

## Folder Structure

```
_brain/
├── claude.md               ← Brain controller (DO NOT MODIFY)
├── aibrain.md               ← Alias entry point (points back to claude.md)
├── INDEX.md                 ← "I need to... → read this file" lookup table
├── overview/                ← Single-page summary of what this _brain system can do
│   └── system_summary.md    ← Framework-maintained; refreshed by the installer
├── prompts/                ← Paste these into your AI sessions
│   ├── bootstrap_prompt.md ← Start a new project
│   ├── continue_prompt.md  ← Resume work
│   └── debug_prompt.md     ← Fix something broken
├── fixes/                   ← BUG FIX MEMORY — always generated, core layer
│   ├── README.md
│   ├── fix_log.md           ← Checked before every debug session, updated after every fix
│   └── _template.md         ← Copy for non-obvious/recurring fixes
├── quick-ref/                ← TOKEN-EFFICIENCY LAYER — always generated
│   ├── README.md
│   ├── commands.md           ← Every command actually used in this project
│   └── snippets.md           ← Canonical code patterns for this project
├── memory/                 ← Project context and architecture
│   ├── app_context.md
│   ├── system_architecture.md
│   ├── glossary.md
│   └── global_brain_link.md ← Optional link to a personal cross-project memory repo
├── progress/               ← Task tracking
│   ├── progress.md         ← AI reads this every session
│   └── backlog.md
├── tasks/                  ← Task rules and templates
│   ├── task_rules.md
│   └── task_templates.md
├── decisions/              ← Architecture and scope decisions
│   ├── decision_log.md
│   └── rejected_options.md
├── timelines/              ← Technical and business timelines
│   ├── actual_timeline.md
│   └── reported_timeline.md
├── summaries/              ← State snapshots
│   ├── current_state.md    ← AI reads this every session
│   └── weekly_summary.md
├── interaction/            ← AI response rules
│   ├── assumptions.md
│   └── response_rules.md
├── governance/             ← Scope and authority rules
│   ├── rules.md
│   └── scope.md
├── security/               ← Auth and secrets policy (optional module)
│   ├── auth_boundaries.md
│   └── secrets_policy.md
├── deployment/             ← Deployment plan and environments (optional module)
│   ├── deployment.md
│   └── environments.md
├── db_backup/                ← DB backup policy — optional, only if project has a database
│   └── backup_policy.md
├── releases/                ← Versioning and changelog (optional module)
│   ├── changelog.md
│   └── versioning.md
├── skills/                 ← Tech stack and references
│   ├── skills.md
│   └── resources.md
├── improvements/             ← Parking lot for non-urgent optimization ideas (optional)
│   └── improvement_log.md
├── tools/                    ← Inventory of CLI tools/scripts used (optional)
│   └── tool_inventory.md
├── staging/                  ← Scratch space for AI draft output (created on first use)
│   └── README.md
├── templates/                ← Reusable templates + self-update tooling
│   ├── update_rules.md       ← What's safe to overwrite vs. never touch on update
│   ├── repo_init_script.sh   ← Re-run any time to pull the latest framework files
│   └── entrypoints/          ← Source files the installer copies to your project root
└── guides/
    └── new_machine_setup.md ← Onboarding a new machine or developer
```

At your project root, the installer also places (only where none already exists):
`CLAUDE.md`, `AGENTS.md`, `.cursorrules`, `.windsurfrules`, `.github/copilot-instructions.md` —
each just a pointer telling whatever AI tool auto-loads it to read `_brain/claude.md` first.

---

## Token Efficiency

AI Nexus is designed to keep context small and predictable.

| Metric | Uncontrolled AI | With AI Nexus |
|---|---|---|
| Files read per session | All (full repo scan) | 2–3 files max |
| Tasks per session | Multiple (unbounded) | Exactly one |
| Token usage (medium project) | ~250,000 | ~90,000 |
| Reduction | — | ~55–65% |

---

## Rules

- `claude.md` is the only file that controls AI behavior — never modify it during a project
- Every AI tool must read `claude.md` in full before touching anything else — that's what the
  root-level `CLAUDE.md` / `AGENTS.md` / `.cursorrules` / `.windsurfrules` /
  `.github/copilot-instructions.md` pointer files enforce
- All other `_brain/` files are data — the AI reads and writes them, you can read them anytime
- Never skip a state
- Never ask the AI to execute multiple tasks in one session
- Never fix a bug without checking `fixes/fix_log.md` first, and never finish one without logging it
- If something is unclear, consult `interaction/assumptions.md` — the AI is required to ask rather than guess

---

## Global Brain (Optional)

Each project's `_brain/` is scoped to that one project — a new project always starts blank. If
you want preferences and recurring patterns to carry over between your projects too, build a
second, separate repo for that. It's small — three files.

### 1. Create it

```bash
# Create an empty repo on GitHub (private recommended, it'll hold personal preferences),
# then clone it anywhere outside your other projects:
git clone https://github.com/<you>/<your-global-brain>.git
```

### 2. Give it this shape

```
your-global-brain/
├── GLOBAL.md              ← entry point: what this repo is, read order, authority rule
├── preferences.md          ← things true across every project you build
└── patterns/
    └── pattern_log.md      ← bugs/decisions that recurred in 2+ projects
```

**`GLOBAL.md`** — tells the AI how and when to read the rest of this repo:

```markdown
# GLOBAL BRAIN — ENTRY POINT
Read GLOBAL.md + preferences.md once per session, right after the project's own claude.md.
Local project files always win over anything here on conflict.
Only open patterns/pattern_log.md when doing a bug fix or architecture decision.
```

**`preferences.md`** — example entry:

```markdown
## Verify before claiming done
Run the actual thing before reporting success — don't assert it works from reading the code.
**Why:** caught two real bugs in installer scripts that looked correct on read.
```

**`patterns/pattern_log.md`** — example entry:

```markdown
| ID   | Pattern                                              | Category   | Seen In               | Fix                                             | Date       |
|------|-------------------------------------------------------|------------|------------------------|--------------------------------------------------|------------|
| G001 | Relative paths break when script run from another cwd | AUTOMATION | project-a, project-b  | Resolve paths from script location, not cwd     | 2026-06-15 |
```

### 3. Link a project to it

Set the path in that project's `_brain/memory/global_brain_link.md`:

```
## Path
C:/dev/your-global-brain
```

From then on, every session in that project reads your global preferences right after its own
`claude.md` — local project files still win if anything conflicts.

### Why bother

- Project 1 hits a bug once, logs the fix locally, and — since it recurred elsewhere — promotes
  it to `pattern_log.md`
- Project 2 hits the same class of bug, but the fix is already known before the AI starts
  debugging
- Project 3 never writes the buggy code in the first place, because the pattern existed before
  the first line was typed

Each new project starts blank on its own. The global repo is what makes project 3 smarter than
project 1, for free, without a subscription.

---

## Who This Is For

- Developers building serious AI-assisted projects
- Anyone hitting token limits or losing context across sessions
- Teams who need predictable, repeatable AI outputs
- Long-running or multi-phase builds where consistency matters

---

## License

Free to use and modify.
