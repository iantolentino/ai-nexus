# AI OPERATING SYSTEM (BRAIN CONTROLLER)

ENTRY POINT:
This system is controlled ONLY through this file: `_brain/claude.md`.
`_brain/aibrain.md` is an alias — same entry point, different filename, for tools that look for
that name instead. It is not a second source of truth; it just points back here.

MANDATORY FIRST READ:
Every AI tool operating on this repository — regardless of vendor (Claude, GPT, Copilot, Cursor,
Windsurf, or any other) — MUST read this file in full BEFORE reading README.md, source code, or
anything else. Root-level pointer files (`CLAUDE.md`, `AGENTS.md`, `.cursorrules`, `.windsurfrules`,
`.github/copilot-instructions.md`) exist for the sole purpose of forcing that first read, since most
AI tools auto-load one of those filenames. They contain nothing but a pointer to this file.

This is the primary token-saving mechanism of AI Nexus: one small file read up front replaces a
full, repeated repository scan every session.

This file is the SINGLE SOURCE OF TRUTH for system initialization.

---

# 🌐 GLOBAL BRAIN LINK (OPTIONAL)

Check `memory/global_brain_link.md`. If its Path is not "none":
- Read that repo's `GLOBAL.md` and `preferences.md` once per session, right after this file,
  before BOOTSTRAP_MODE or EXECUTION_MODE begins
- Local `_brain/` files always win over anything in the global repo on conflict
- Only open the global repo's `patterns/pattern_log.md` when doing a bug fix or architecture
  decision — same lazy-load rule as this project's own `fixes/fix_log.md`

If Path is "none", skip this — most sessions don't need a global brain repo.

---

# ⚠️ MANDATORY CODE REVIEW MINDSET (EVERY SESSION)

**THIS APPLIES TO ALL AI OPERATIONS — NOT JUST CODE REVIEW SESSIONS.**

Before executing ANY task (bootstrap, execution, planning, debugging, etc.), internalize:

Read these FIRST (after this file, before doing anything):
1. `governance/code_review_rules.md` — severity baselines, what matters at scale
2. `skills/code_review_checklist.md` — 5-category evaluation framework

**Core rule:** Every output must pass these checks:

**BUGS & CORRECTNESS:** No logic errors, nulls, race conditions, error handling gaps, edge cases, resource leaks
**SECURITY:** No SQL injection, XSS, CSRF, auth bypass, secrets exposure, unvalidated input
**PERFORMANCE:** No N+1 queries, unbounded memory, expensive loops, blocking operations
**MAINTAINABILITY:** Code is readable, DRY, SOLID, not overly complex, tests pass
**SCALABILITY:** Works at 10x users, 100x data, 2x features — no hard-coded limits

**Decision:** If any output you generate would fail these checks → FIX BEFORE STOPPING. Do not accept partial quality.

This is not a "nice to have" — it is a HARD CONSTRAINT on all AI output in this project.

---

# 🎯 GOAL

- Senior-level software architecture decision-making
- Prevent overengineering AND underengineering
- Token-efficient execution with controlled planning overhead
- Production-grade output for ANY program type — web app, backend service, CLI tool, script,
  or automation/workflow — not just business SaaS
- STRICT task completion guarantee (no partial outputs)
- Deterministic execution flow (state machine + dependency graph)
- Real-world systems at whatever scale the project actually needs (solo script → enterprise SaaS)

---

# 0. PRIORITY HIERARCHY

1. **CODE REVIEW GATES** (bugs, security, performance, maintainability, scalability checks)
2. COMPLETION GUARANTEE ENGINE (task must be fully usable)
3. VALUE GATE (only meaningful work allowed)
4. DECISION ENGINE (architecture logic)
5. DEPENDENCY GRAPH SYSTEM (execution ordering)
6. STATE MACHINE RULES
7. GLOBAL CONSTRAINTS
8. TOKEN OPTIMIZATION LAYER

**NOTE:** Code review gates apply to ALL output, ALL states, ALL tasks. They are not optional.

---

# 1. CORE PRINCIPLE (SENIOR ENGINEERING RULE)

The AI must:

- Never assume requirements
- Never overbuild early
- Never underdeliver functionality
- Design for EVOLUTION, not static architecture
- Prefer scalable simplicity over premature abstraction
- ALWAYS produce usable output per task cycle
- NEVER leave incomplete system states

---

# 2. SENIOR ARCHITECTURE MINDSET

Every decision must consider:

- CURRENT NEED (MVP requirement)
- FUTURE SCALE (growth projection)
- CHANGE COST (maintenance cost)
- COMPLEXITY IMPACT (system burden)
- BUSINESS VALUE (mandatory filter)

Final decision types:

- BUILD NOW
- DEFER (hook only)
- REJECT

---

# 3. DECISION ENGINE

## 3.1 FEATURE CLASSIFICATION

- CORE → required now
- SCALE-READY → lightweight implementation + extension hook
- DEFERRED → planned but not implemented
- REJECTED → removed from system

---

## 3.2 ARCHITECTURE BALANCE RULE

Avoid:

- overengineering
- underengineering

Preferred:

> minimal production core + structured extensibility

---

## 3.3 SCALING RULE

Evaluate:

- user growth
- data growth
- feature expansion
- operational load

If scaling risk exists:
→ add abstraction ONLY when justified

---

## 3.4 DEFERRED COMPLEXITY RULE

If feature is future-needed:

- DO NOT fully implement
- DO NOT discard idea
- CREATE hook only:
  - interface OR
  - folder OR
  - extension point

---

## 3.5 DEPENDENCY GRAPH ENGINE (NEW CORE)

All features MUST be mapped as:

- nodes = tasks/features
- edges = dependencies

Rules:
- No task executes without dependency clearance
- Blocked tasks remain queued
- Execution order is deterministic

---

## 3.6 COMPLETION GUARANTEE ENGINE (CRITICAL)

A task is ONLY complete when:

- Output is immediately usable
- No missing dependencies
- No hidden TODOs required for MVP
- System works in intended environment
- Integration is valid

If NOT met → task is NOT complete

---

## 3.7 FINAL COMPLETION CHECK (MANDATORY)

Before stopping:

- Is output usable now?
- Does anything block execution?
- Is another task required?

If YES → continue execution

---

## 3.8 NO-STALL RULE

AI must NEVER:

- stop mid-task without output
- loop planning without execution
- delay due to uncertainty
- request repeated confirmations after lock

If blocked:
→ choose minimal viable implementation OR mark BLOCKED explicitly

---

## 💼 3.9 VALUE GATE

No feature exists unless it satisfies at least ONE:

- increases revenue
- reduces cost
- improves efficiency (including: saves manual/repetitive effort — the primary value metric
  for automations and scripts, which have no "revenue" of their own)
- reduces risk
- improves user/operator outcome

"Business" outcome = the reason this program exists, whether that's a company, a personal
automation, or an internal tool. The gate applies the same way regardless of project type.

Otherwise:
→ REJECT or DEFER

---

## 💰 3.10 TOKEN EFFICIENCY RULE

- assume prior state is known
- avoid repetition
- compress reasoning into bullets
- prefer structured outputs

Priority:
1. tables
2. bullets
3. schemas
4. minimal prose

---

# 🔵 STATE 1 — BOOTSTRAP_MODE

TRIGGER:
If system uninitialized OR no confirmed specification exists.

RULES:
- ONLY read claude.md / aibrain.md
- NO coding
- NO architecture generation
- NO assumptions

SPEC COLLECTION:
- project type
- domain
- users
- workflow
- features
- scale
- stack
- constraints

---

# 🔒 STATE 2 — CONFIRMATION_LOCK

OUTPUT ONLY:
- feature classification (CORE / SCALE / DEFER / REJECT)
- dependency graph summary
- high-level architecture
- risks
- confirmation request

Allowed responses:
- confirm
- approved
- proceed

---

# 🟡 STATE 3 — SYSTEM_GENERATION

Triggered ONLY after confirmation.

---

## SYSTEM SIZE RULE

SMALL:
- progress
- tasks

MEDIUM:
- memory
- decisions
- timelines

LARGE:
- full system (enterprise scale)

---

## MEMORY LAYER

memory/
- app_context.md
- system_architecture.md
- glossary.md
- dependency_graph.md

---

## TASK SYSTEM

tasks/
- atomic_tasks.md
- execution_queue.md
- task_rules.md
- task_templates.md

---

## PROGRESS SYSTEM

progress/
- progress.md
- backlog.md

---

## DECISIONS SYSTEM

decisions/
- decision_log.md
- rejected_options.md

Format:
[TYPE] → decision
Impact: low | medium | high
Reason: 1 line max

---

## TIMELINES

timelines/
- actual_timeline.md
- reported_timeline.md

Must include:
- phases
- dependencies
- scaling checkpoints

---

## FIX MEMORY LAYER (ALWAYS GENERATED — NOT OPTIONAL)

fixes/
- README.md
- fix_log.md
- _template.md

This folder is core, not optional, at any system size. See § BUG FIX MEMORY LAYER below.

---

## TOKEN-EFFICIENCY LAYER (ALWAYS GENERATED — NOT OPTIONAL)

quick-ref/
- README.md
- commands.md
- snippets.md

Fill with real commands/patterns as soon as they exist — an empty quick-ref/ saves nothing.

---

## OPTIONAL MODULE RULE

Only generate if required:

- deployment/
- security/
- releases/
- improvements/ — generate once the project is past MVP and non-urgent ideas start accumulating
- tools/ — generate once the project uses more than one CLI tool worth remembering
- db_backup/ — generate ONLY if the project has a database
- staging/ — generate on first use (AI needs scratch space for a draft mid-task)

Otherwise omit

---

# 🧩 BUG FIX MEMORY LAYER

Applies whenever a bug-fix task (`B###`, or any DEBUG_PROMPT session) runs, in any state that
touches EXECUTION_MODE.

BEFORE fixing:
1. Read `fixes/fix_log.md`
2. If a matching or related entry exists, reuse its root cause / fix instead of re-diagnosing

AFTER fixing:
1. Add one row to `fixes/fix_log.md` — always, no exceptions, even for a one-line fix
2. If the fix was non-obvious or is likely to recur, also create `fixes/F###-slug.md` from
   `fixes/_template.md` and link it from the log row
3. Never delete a fix entry. If superseded, mark `SUPERSEDED` and link the replacement.

This is what makes fixes/ actual memory instead of a changelog: the log is read BEFORE work, not
just written after it.

---

# 🟢 STATE 4 — EXECUTION_MODE

## STRICT FLOW

1. Read:
   - progress/progress.md
   - summaries/current_state.md

2. Select ONE atomic task ONLY

3. Validate dependency graph

3.5. If the task is a bug fix (`B###`): check `fixes/fix_log.md` first — see § BUG FIX MEMORY LAYER.
     If unsure which other file covers something needed for this task, check `INDEX.md` before
     reading speculatively.

4. EXECUTE (production-ready output)

5. COMPLETION CHECK:
   - usable immediately?
   - dependencies resolved?
   - integration valid?

If NOT → fix before continuing

6. Update only changed files (minimal diff). If this was a bug fix, this includes
   `fixes/fix_log.md` — see § BUG FIX MEMORY LAYER.

7. STOP

---

# 🔁 EXECUTION LOOP RULE

- one atomic task per cycle
- no batching
- no multi-task execution
- no re-planning mid-cycle
- no partial completion accepted

---

# ⏳ TIMELINE SYSTEM

actual_timeline.md:
- technical execution phases
- scaling checkpoints

reported_timeline.md:
- simplified business-safe timeline

---

# ⚠️ HARD CONSTRAINTS

- no assumptions
- no skipping states
- no premature optimization
- no overengineering
- no full repo scans unless required
- no partial delivery as completion
- one task per cycle
- completion > design purity

---

# 🧠 SENIOR OPTIMIZATION LAYER

## CONTEXT STABILITY RULE
Treat claude.md / aibrain.md as authoritative state snapshot

---

## OUTPUT COMPRESSION RULE

- bullets over paragraphs
- no repetition
- no restating known state

---

## EFFICIENCY RULE

Only process:
- changed files
- active tasks

---

## ARCHITECTURAL EVOLUTION RULE

System evolves in phases:

1. MVP
2. SCALE PREP
3. SCALING

---

# 🔍 CODE_REVIEW MODE (SPECIAL EXECUTION CONTEXT)

Code review is a special mode outside the normal state machine. Triggered when:
- User pastes `_brain/prompts/code_review_prompt.md` into a session
- User explicitly asks for code review of a branch, PR, or diff

## CODE_REVIEW FLOW

1. Read `_brain/claude.md` (full) — understand project standards
2. Read `_brain/governance/code_review_rules.md` — file skip patterns and severity baselines
3. Read `_brain/skills/code_review_checklist.md` — evaluation framework
4. Read `_brain/memory/app_context.md` (if exists) — project domain/constraints
5. Check `_brain/fixes/fix_log.md` — skip findings already logged

6. Identify files to review from user input (branch, PR, diff, or file list)

7. Apply file skip patterns:
   - **Always skip:** build/, node_modules/, dist/, .git/, .env.*, *.lock, coverage/
   - **Skip unless explicitly requested:** test files, config files, docs/, markdown
   - See `code_review_rules.md` for full patterns

8. Review ONLY production code — prioritize by file type:
   - Core business logic (highest risk)
   - Supporting infrastructure (medium risk)
   - UI/display layer (lower risk, but security-sensitive)
   - Configuration (skip unless requested)

9. Evaluate each file against the checklist:
   - BUGS & CORRECTNESS (logic, nulls, error handling, edge cases, resources, concurrency)
   - SECURITY (input validation, SQLi, XSS, auth/authz, secrets, CSRF)
   - PERFORMANCE (queries, computation, memory, rendering, network)
   - MAINTAINABILITY (clarity, DRY, SOLID, dead code, testing, docs)
   - SCALABILITY (architecture, database, concurrency, caching, load handling)

10. Report findings by severity:
    - CRITICAL: Breaks functionality, security breach, data loss
    - HIGH: Missing error handling, N+1 queries, unhandled exceptions
    - MEDIUM: Code quality, maintainability debt, minor performance issues
    - LOW: Style, nice-to-have optimizations, documentation

11. Output format for each finding:
    ```
    ## [SEVERITY] Finding Title
    **File:** path/to/file.ts:42
    **Category:** [BUGS | SECURITY | PERFORMANCE | MAINTAINABILITY | SCALABILITY]
    **What:** 1 sentence
    **Why it matters:** Impact
    **Fix:** Recommendation
    ```

12. Complete check:
    - All non-skipped files reviewed?
    - Findings organized by severity?
    - Checked fix_log.md for duplicates?
    - Findings are actionable and specific?

13. Report findings (or "No findings" if clean)

14. One sentence on overall code quality

15. STOP

## CODE_REVIEW PRIORITY

- Protect production from bugs, security issues, and technical debt
- Skip efficiency nitpicks
- Focus on what actually breaks or matters at scale
- Be precise: file + line + specific issue
- Check memory first: if already logged, skip
- No praise; focus on improvements

## CODE_REVIEW TOKEN EFFICIENCY

File skip patterns reduce token usage by 30–40%:
- Skips test files (50% of many projects)
- Skips node_modules, build artifacts, .git
- Skips config files unless reviewing configuration
- Prioritizes core logic (high-value review)

Result: Review production code quality without reading boilerplate.

---

# 🏁 RESULT

- deterministic execution engine
- dependency-aware task system
- strict completion enforcement
- token-efficient decision model
- scalable enterprise architecture design
- production-grade software delivery guarantee
