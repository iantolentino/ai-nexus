# ai-nexus (AI Project Control Framework)

## Overview

ai-nexus is a structured AI-driven project execution system that controls how an AI assistant plans, designs, and builds software projects.

It enforces a strict, deterministic lifecycle that eliminates ambiguity, prevents assumption-based reasoning, and ensures consistent execution across any project type (web apps, SaaS platforms, APIs, automation systems, and more).

The system is designed as a reusable project foundation that turns any repository into a controlled AI execution environment.

---

## Core Principle

The AI must never rely on assumptions.

All decisions, architecture, tasks, timelines, and execution steps must be derived strictly from structured files inside the `_brain` system.

If information is missing, the AI must request it. It must never fill gaps with inference.

---

## System Lifecycle

The system operates through four mandatory phases:

1. BOOTSTRAP MODE
2. CONFIRMATION LOCK
3. SYSTEM GENERATION
4. EXECUTION MODE

No phase may be skipped or reordered.

---

## How to Use _brain

### 1. Initialization

Open the project in VS Code and ensure the `_brain` directory exists at the root.

Start the system with:

Read claude.md only. Start bootstrap mode.

This forces the AI into controlled initialization.

---

### 2. BOOTSTRAP MODE

In this phase, the AI collects complete project requirements before any planning or generation begins.

It must gather:

* Project type (app, website, system, API, automation tool)
* Domain (e.g. ticketing system, CRM, SaaS platform)
* Target users (end users, internal staff, admins, public users)
* Full feature list (detailed and complete)
* Feature priority (must-have, should-have, nice-to-have)
* Workflow description (step-by-step user/system flow)
* Engineering level (basic, mid-level, senior-level)
* Performance scale (small, medium, enterprise)
* Security level (low, standard, strict)
* UI style (minimal, modern, corporate, dark, custom)
* Design references (if available)
* Tech stack constraints (frontend, backend, database)
* Deployment preferences

No code generation or file writing is allowed in this phase.

---

### 3. CONFIRMATION LOCK

After collecting all requirements, the AI must:

* Consolidate and summarize the full specification
* Present it clearly to the user
* Request explicit confirmation to proceed

Valid confirmations only:

* confirm
* approved
* proceed

Until confirmation is received:

* No file writing
* No architecture generation
* No coding

---

### 4. SYSTEM GENERATION

Once confirmed, the AI generates and writes all `_brain` files based strictly on the approved specification.

This phase establishes the full project structure.

---

## Memory Layer

* memory/app_context.md
* memory/system_architecture.md
* memory/glossary.md

## Task System

* progress/progress.md
* progress/backlog.md
* tasks/task_rules.md
* tasks/task_templates.md

## Decision System

* decisions/decision_log.md
* decisions/rejected_options.md

## Skills System

* skills/skills.md
* skills/resources.md

## Deployment System

* deployment/deployment.md
* deployment/environments.md

## Timeline System

* timelines/actual_timeline.md
* timelines/reported_timeline.md

## Summaries

* summaries/current_state.md
* summaries/weekly_summary.md

## Interaction Layer

* interaction/response_rules.md
* interaction/assumptions.md

## Governance

* governance/rules.md
* governance/scope.md

## Security

* security/secrets_policy.md
* security/auth_boundaries.md

## Releases

* releases/changelog.md
* releases/versioning.md

## Prompts

* prompts/bootstrap_prompt.md
* prompts/continue_prompt.md
* prompts/debug_prompt.md

No implementation code is written in this phase.

---

### 5. EXECUTION MODE

After system generation is complete, the AI enters execution mode.

Execution follows a strict loop:

1. Read:

   * progress/progress.md
   * summaries/current_state.md

2. Select exactly one task

3. Execute only that task

4. Update:

   * progress.md
   * current_state.md

5. Stop

No multi-tasking is allowed unless explicitly instructed.

---

## File Responsibilities

claude.md
Defines system behavior, lifecycle rules, and state transitions.

progress/progress.md
Single source of truth for active tasks.

summaries/current_state.md
Live compressed snapshot of project status.

memory/app_context.md
Defines what is being built and why.

memory/system_architecture.md
Defines technical design and system structure.

decisions/*
Stores architectural decisions and rejected alternatives.

timelines/*
Defines project scheduling:

* actual_timeline.md = optimized execution plan
* reported_timeline.md = external-safe timeline

---

## Key Rules

* Never assume missing information
* Never skip system phases
* Never read the full repository at once
* Never generate code before SYSTEM GENERATION
* Always execute one task at a time
* Always update progress after each task
* Always follow the structured file system

---

## Usage Flow

For every project:

1. Initialize `_brain`
2. Start bootstrap via `claude.md`
3. Collect full requirements
4. Confirm specification
5. Generate full system structure
6. Begin execution loop

---

## Outcome

Using ai-nexus creates a controlled AI development environment that:

* Maintains persistent project memory
* Eliminates repeated context explanation
* Reduces token usage
* Enforces structured execution
* Enables scalable development across any project type

---
