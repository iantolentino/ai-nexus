# AI Nexus Framework State

## Current objective

Maintain a provider-neutral, minimal-context framework that reduces unnecessary AI context across projects.

## Active architecture facts

- `AI_BRAIN.md` is the sole universal controller.
- Provider entry files are small adapters that point to the controller and selector.
- Markdown is the primary knowledge source; no provider-specific memory or token API is required.

## Current implementation state

- Minimal-context brain, handoffs, daily logs, intent profiles, context selector, Brain Doctor, and metrics are implemented.
- Legacy full-controller, progress, summary, timeline, task, and scribe templates were removed from the source template.

## Immediate next action

Improve only features that reduce context size, improve reliable continuity, or make selected context easier to use.

Last updated: 2026-08-16
