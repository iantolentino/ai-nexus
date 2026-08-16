# AI Nexus framework repository

This repository builds the AI Nexus template. Use `_brain/AI_BRAIN.md` as the controller, but do not use template `CURRENT_STATE.md` as framework state.

Before changes, run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File _brain/tools/select-context.ps1 -Intent framework-maintenance -NoManifest
```

Read only the selected files and task-relevant template or installer files. Update `FRAMEWORK_STATE.md` when the framework's active state changes. Do not modify or remove template knowledge without user approval.
