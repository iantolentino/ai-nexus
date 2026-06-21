# GOVERNANCE RULES

## Authority Hierarchy
1. `claude.md` / `aibrain.md` — single source of truth for AI behavior
2. `memory/app_context.md` — confirmed project specification
3. `progress/backlog.md` — confirmed task scope
4. All other `_brain/` files — supporting data

If any conflict exists between files, the higher authority wins.
If `claude.md` conflicts with any other file, `claude.md` wins — always.

---

## What the AI May Do Per State

| State               | May Read                         | May Write              | May Generate Code |
|---------------------|----------------------------------|------------------------|--------------------|
| BOOTSTRAP_MODE      | claude.md only                   | nothing                | no                 |
| CONFIRMATION_LOCK   | claude.md only                   | nothing                | no                 |
| SYSTEM_GENERATION   | claude.md                        | all `_brain/` files    | no                 |
| EXECUTION_MODE      | progress.md, current_state.md    | task output only       | yes                |

---

## Change Control
- Architecture changes → log in `decisions/decision_log.md`
- Rejected features → log in `decisions/rejected_options.md`
- Scope additions → update `progress/backlog.md` and `timelines/actual_timeline.md`
- Scope removals → log reason in `decisions/rejected_options.md`

---

## What the AI Must Never Do
- Scan the full repository without explicit instruction
- Execute more than one task per session
- Skip a state in the state machine
- Overwrite confirmed decisions without user approval
- Generate implementation code outside EXECUTION_MODE
