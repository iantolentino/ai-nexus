````md
# AI Nexus — AI Project Control System

AI Nexus is a **state-driven AI project control framework** designed to enforce deterministic behavior, prevent assumptions, and significantly reduce token consumption when using AI to build software projects.

This repository does **not** contain application code.  
It contains the **control system that governs how an AI plans, structures, and executes a project**.

---

## What This Repository Is

AI Nexus is an **AI operating system**, not a prompt and not a chatbot configuration.

It defines:
- When the AI may read files
- When the AI may write files
- When the AI may plan architecture
- When the AI may generate implementation code

All behavior is enforced through a strict state machine defined in `_brain/aibrain.md`.

---

## Why AI Nexus Exists

Most AI-assisted projects fail due to:
- Uncontrolled assumptions
- Context bloat and runaway token usage
- Mixing planning and execution
- Inconsistent outputs across sessions

AI Nexus solves this by enforcing **explicit states, hard rules, and controlled memory access**.

---

## Core Design Principles

- No assumptions, ever
- Planning must precede execution
- Memory is written deliberately, not inferred
- Execution is single-task and stoppable
- Context is minimized at all times

---

## The Brain Controller (`_brain/aibrain.md`)

`aibrain.md` is the **single source of truth** for AI behavior.

It defines four immutable system states:

### 1. BOOTSTRAP_MODE
- AI reads only `aibrain.md`
- AI collects full project specification
- No other files are read
- No files are written
- No architecture or code is generated

### 2. CONFIRMATION_LOCK
- AI summarizes the full specification
- AI waits for explicit approval
- No assumptions
- No file writes
- No code generation

### 3. SYSTEM_GENERATION
- AI writes the complete `_brain/` structure
- Architecture, tasks, timelines, governance
- Planning only
- No implementation code allowed

### 4. EXECUTION_MODE
- AI reads only:
  - `progress/progress.md`
  - `summaries/current_state.md`
- AI selects exactly one task
- AI executes the task
- AI updates memory
- AI stops

No state may be skipped.

---

## Repository Structure

```text
_brain/
├── aibrain.md               # AI controller and state machine
├── memory/                  # Project definition and architecture
├── progress/                # Task list and execution status
├── tasks/                   # Task rules and templates
├── decisions/               # Accepted and rejected decisions
├── skills/                  # Stack and learning resources
├── deployment/              # Deployment strategy
├── timelines/               # Actual vs reported timelines
├── summaries/               # State snapshots
├── interaction/             # Response and assumption rules
├── governance/              # Scope and authority rules
├── security/                # Auth and secret handling
├── releases/                # Versioning and changelog
└── prompts/                 # Reusable AI prompts
````

---

## Token Efficiency and Measured Impact

AI Nexus is designed to **cap context growth** and prevent exponential token usage.

### Typical Uncontrolled AI Workflow

* Full repo scan per session
* Repeated architecture re-ingestion
* Multi-task execution in one response
* Context window exhaustion

**Estimated usage over a medium project**:

* 200k–250k tokens per extended session
* Frequent context resets
* Loss of continuity

---

### AI Nexus Controlled Workflow

* Single-file access in early states
* State-gated file loading
* Minimal read set during execution
* One task per execution loop

**Observed and modeled usage**:

* Initial planning phase: ~20k–30k tokens
* System generation phase: ~30k–40k tokens
* Ongoing execution sessions: ~2k–5k tokens per task

**Equivalent project total**:

* ~80k–100k tokens for the same scope

---

### Estimated Efficiency Gains

* Token reduction: **55%–65%**
* Context stability: **high**
* Rework reduction: **significant**
* Session predictability: **deterministic**

Example comparison:

* Uncontrolled approach: ~250,000 tokens
* AI Nexus approach: ~90,000 tokens

Savings scale with project size.

---

## How This Achieves Efficiency

* Files are never all loaded at once
* Planning and execution are isolated
* Memory is explicit and minimal
* Execution context is intentionally small
* AI is forbidden from scanning the repository

---

## How to Use This Repository

1. Clone the repository
2. Start a new AI session
3. Provide the contents of `_brain/aibrain.md` # initially it is set as claude.md
4. Allow the AI to enter BOOTSTRAP_MODE
5. Answer specification questions
6. Approve the confirmation summary
7. Allow SYSTEM_GENERATION to complete
8. Execute tasks one at a time in EXECUTION_MODE

---

## Who This Is For

* Developers building serious AI-assisted projects
* Teams hitting token limits
* Long-running or multi-phase builds
* Anyone needing predictable AI behavior

---

## What This Is Not

* Not a chatbot prompt
* Not an autonomous agent
* Not a codebase generator without oversight

---

## License

Feel free to use and Modify

```
