# AI Nexus

AI Nexus is a context-management framework for AI-assisted development. Its goal is controlled context with reliable continuity: load the smallest useful knowledge set, then expand only when a task proves it necessary.

This file is the single universal controller for AI Nexus. Provider-specific files such as `AGENTS.md` and `CLAUDE.md` are only small adapters that direct their AI tool here.

## Authority

- `AI_BRAIN.md` defines the operating policy.
- `BRAIN_INDEX.md` maps questions and intents to authoritative knowledge.
- `CURRENT_STATE.md` is the compact view of the project now.
- `sessions/LATEST_HANDOFF.md` is the continuation snapshot.
- `daily/YYYY-MM-DD.md` records activity for one day.
- `decisions/` and `architecture/` preserve durable knowledge.

Legacy files remain available for existing projects. They are historical/supporting knowledge unless `BRAIN_INDEX.md` explicitly marks one as active.

## Default context

Start every session with `BRAIN_INDEX.md`, `CURRENT_STATE.md`, and `sessions/LATEST_HANDOFF.md`. Read today's daily log when continuing active work. Do not scan the repository or load historical brain files by default.

Determine the intent, use its profile in `intents/`, and load only the named supporting sources. Expand one level at a time and state the exact missing knowledge before doing so.

Use `tools/select-context.ps1` to generate an auditable context plan and session manifest when PowerShell is available.

## Session continuity

At a meaningful milestone, update today's daily log and `CURRENT_STATE.md` if project state changed. Before pausing, write a compact, actionable `sessions/LATEST_HANDOFF.md`, then run `tools/handoff-baseline.ps1 -UpdateHandoff`. At continuation, run `tools/context-diff.ps1` when a valid baseline exists, before selecting task context. Archive superseded handoffs in `sessions/archive/`.

About every hour, or before a broad context expansion, run `tools/session-checkpoint.ps1`. If it reports YELLOW or RED, offer a concise choice to continue, compact context, generate a handoff, or start a fresh session. It is a reminder, never a forced rotation.

Run `tools/brain-doctor.ps1` periodically to detect stale, oversized, contradictory, or broken active knowledge.
