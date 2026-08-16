# Continue Session Policy

Continue the current task using only the provided active context. Do not scan or read the full repository automatically.

Start with:

1. `AI_BRAIN.md`
2. `BRAIN_INDEX.md`
3. `CURRENT_STATE.md`
4. `sessions/LATEST_HANDOFF.md`
5. Today's daily progress log, when relevant

Identify the intent and use its profile in `intents/`. Load only the minimum supporting files required to complete the task correctly. If information is missing, identify the exact missing fact and load the mapped source at the next context level; do not load unrelated files.

At meaningful milestones, update today's daily log and `CURRENT_STATE.md` when state changes. Before stopping, write a compact handoff. Never claim an exact token budget unless the provider reliably exposes it.
