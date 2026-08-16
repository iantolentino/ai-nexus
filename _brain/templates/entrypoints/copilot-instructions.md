# AI Nexus context policy

Read `_brain/AI_BRAIN.md`, the single AI Nexus controller. If a handoff baseline exists, run `_brain/tools/context-diff.ps1`. Determine the task intent. Use `_brain/tools/select-context.ps1` when available, then read only
its selected files. Do not scan the repository or read full project history by default.

> Installer note: this file belongs at `.github/copilot-instructions.md` in the target project.
