# Provider entry-point templates

The installers copy one of these small files to a project root only when the destination does not already exist.

| Template | Intended tool | Destination |
| --- | --- | --- |
| `AGENTS.md` | Codex | `AGENTS.md` |
| `CLAUDE.md` | Claude Code | `CLAUDE.md` |
| `.cursorrules` | Cursor | `.cursorrules` |
| `.windsurfrules` | Windsurf | `.windsurfrules` |
| `copilot-instructions.md` | GitHub Copilot | `.github/copilot-instructions.md` |

Each template enforces the same provider-neutral policy: identify intent, run AI Nexus context selection, and read only the selected files. They must not require a full read of `_brain/claude.md`.

If a project already has an instruction file, the installer leaves it untouched. Merge the AI Nexus context policy into that file manually.
