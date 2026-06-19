# _brain Operating System (AI Project Control Framework)

## Overview

_brain is a structured AI project execution system designed to control how an AI assistant plans, generates, and builds software projects.

It enforces a strict lifecycle that removes ambiguity, reduces repeated context loading, and ensures consistent execution across any type of project (web app, SaaS, API, automation tool, etc.).

The system is designed to be reusable and works as a universal project foundation.

---

## Core Principle

The AI must never rely on assumptions.

All decisions, architecture, tasks, timelines, and execution steps must be derived from structured files inside _brain.

---

## System Lifecycle

The system always follows four strict phases:

1. BOOTSTRAP MODE
2. CONFIRMATION LOCK
3. SYSTEM GENERATION
4. EXECUTION MODE

No phase may be skipped.

---

## How to Use _brain

### 1. Initialization

Open your project in VS Code and ensure the _brain folder exists at the root.

Start the system by instructing the AI:

Read claude.md only. Start bootstrap mode.

This forces the AI to enter controlled initialization mode.

---

### 2. BOOTSTRAP MODE

In this phase, the AI collects full project requirements.

It must ask and record:

* Project type (app, website, system, API, automation tool)
* Domain (example: ticketing system, CRM, SaaS)
* Target users (end users, internal staff, admins, public users)
* Full feature list
* Feature priority (must-have, should-have, nice-to-have)
* Workflow description (how the system is used step-by-step)
* Engineering level (basic, mid-level, senior-level)
* Performance scale (small, medium, enterprise)
* Security level (low, standard, strict)
* UI style (minimal, modern, corporate, dark, custom)
* Design references (if any)
* Tech stack constraints (frontend, backend, database)
* Deployment preference

No code or file generation is allowed during this phase.

---

### 3. CONFIRMATION LOCK

After collecting all requirements, the AI must:

* Summarize the full specification
* Present it clearly to the user
* Ask for explicit confirmation

Valid confirmations:

* confirm
* approved
* proceed

Until confirmation is received, no file writing or coding is allowed.

---

### 4. SYSTEM GENERATION

Once confirmed, the AI generates and writes all _brain files based on the specification.

This phase builds the entire project structure.

Memory Layer:

* memory/app_context.md
* memory/system_architecture.md
* memory/glossary.md

Task System:

* progress/progress.md
* progress/backlog.md
* tasks/task_rules.md
* tasks/task_templates.md

Decision System:

* decisions/decision_log.md
* decisions/rejected_options.md

Skills System:

* skills/skills.md
* skills/resources.md

Deployment System:

* deployment/deployment.md
* deployment/environments.md

Timelines:

* timelines/actual_timeline.md
* timelines/reported_timeline.md

Summaries:

* summaries/current_state.md
* summaries/weekly_summary.md

Interaction Layer:

* interaction/response_rules.md
* interaction/assumptions.md

Governance:

* governance/rules.md
* governance/scope.md

Security:

* security/secrets_policy.md
* security/auth_boundaries.md

Releases:

* releases/changelog.md
* releases/versioning.md

Prompts:

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

3. Implement only that task

4. Update:

   * progress.md
   * current_state.md

5. Stop execution

No multi-tasking is allowed unless explicitly instructed.

---

## File Responsibilities

claude.md
Controls system behavior, rules, and state transitions.

progress/progress.md
Single source of truth for all tasks.

summaries/current_state.md
Compressed live state of the project.

memory/app_context.md
Defines what the system is building and why.

memory/system_architecture.md
Defines technical architecture and system design.

decisions/*
Stores all locked decisions and rejected alternatives.

timelines/*
Defines project scheduling:

* actual_timeline.md = optimized execution plan
* reported_timeline.md = external-safe timeline

---

## Key Rules

* Never assume missing information
* Never skip system phases
* Never read full repository at once
* Never generate code before SYSTEM GENERATION is complete
* Always execute one task at a time
* Always update progress after every task
* Always follow structured file system

---

## Usage Flow

For every project:

1. Initialize _brain
2. Start bootstrap via claude.md
3. Collect full requirements
4. Confirm specification
5. Generate full system structure
6. Begin execution loop

---

## Result

Using _brain creates a controlled AI development environment that:

* Maintains persistent project memory
* Eliminates repeated explanations
* Reduces token usage
* Enforces structured development
* Enables scalable multi-project workflow
