# Brain Index

Use this index as Question -> Knowledge Needed -> File. Do not search the whole brain when a mapped source exists.

| Question or intent | Knowledge needed | Authoritative source |
| --- | --- | --- |
| What is happening now? | Active state | `CURRENT_STATE.md` |
| How do I continue safely? | Last work snapshot | `sessions/LATEST_HANDOFF.md` |
| What happened today? | Current activity | `daily/YYYY-MM-DD.md` |
| Why was a technical choice made? | Decision record | `decisions/ADR-*.md` |
| How is the system designed? | Architecture | `architecture/ARCHITECTURE.md` |
| Which context fits this task? | Intent profile | `intents/<intent>.md` |
| How should I review this change? | Code-review context | `intents/code-review.md` |
| How should I maintain AI Nexus itself? | Framework-maintenance context | `intents/framework-maintenance.md` |
| What is the recommended minimum context? | Context selector | `tools/select-context.ps1` |
| What did this session load and skip? | Context manifest | `sessions/manifests/context-*.md` |
| What changed since the last handoff? | Git context diff | `tools/context-diff.ps1` and `CONTEXT_DIFF.md` |
| What Git state belongs in a handoff? | Handoff baseline | `tools/handoff-baseline.ps1` |
| How should deployment work? | Operations rules | `deployment/` |
| What was true in the past? | Historical context | `archive/`, legacy folders, or archived handoffs |

## Context levels

1. **Minimal:** `AI_BRAIN.md`, this index, `CURRENT_STATE.md`, latest handoff.
2. **Current work:** today's log, task specification, directly relevant source files.
3. **Supporting knowledge:** the exact architecture, contract, decision, or operations file needed.
4. **Historical:** older logs, archived handoffs, and legacy progress only when the answer cannot be found above.

Record significant new facts with their source. Promote durable decisions to `decisions/`; leave transient debugging detail in daily logs.
