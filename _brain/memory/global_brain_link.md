# GLOBAL BRAIN LINK

> Optional. Points this project at a personal "global brain" repo — a separate repo holding
> your cross-project preferences and patterns, shared by every project you link to it. See
> https://github.com/iantolentino/idt-global-brain for a working example (don't clone that one
> directly — it's tuned to one person; build your own the same shape).
>
> This file is project data — the installer/updater never touches it once you set it.

---

## Path
none

<!-- Replace "none" with the local absolute path to your cloned global-brain repo, e.g.:
     C:/Users/you/global-brain   or   /home/you/global-brain
     Leave as "none" if you don't use a global brain repo. -->

## Rule
If Path is not "none":
- Read `<path>/GLOBAL.md` and `<path>/preferences.md` once per session, right after this
  project's own `claude.md`, before BOOTSTRAP_MODE spec collection or EXECUTION_MODE task
  selection — whichever comes first
- If anything there conflicts with this project's own `_brain/` files, THIS project's files
  win — the global repo supplies defaults, never overrides
- Only read `<path>/patterns/pattern_log.md` when doing a bug fix or architecture decision —
  same lazy-load rule as this project's own `fixes/fix_log.md`
