# Global Claude Code instructions

<!--
Centrally managed global memory for Claude Code, issued to every environment
by the Quartermaster. Project-specific instructions belong in each project's
own CLAUDE.md, not here.

Credentials never live in this directory: ~/.claude.json (OAuth tokens,
history) is generated at install time by apply-home.sh and is not tracked.
-->

- Prefer `uv` for Python dependency and environment management.
- Prefer `gh` for GitHub operations.
