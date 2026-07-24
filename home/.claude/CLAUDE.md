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

## Workflow Requirements

**Every change must be tracked by a GitHub issue.** No commits without an associated issue.

- Before starting work, check for an existing GitHub issue using the `github-issues` skill or GitHub tools
- If no issue exists, create one before making changes
- Reference the issue number in all commit messages (e.g., `Fix data ingestion reconnect logic (#12)`)
- Issue comments are the canonical execution log while work is in progress.
  - Add comments at meaningful milestones, such as:
    - Scope clarified and implementation plan finalized
    - First implementation pass complete
    - Tests added/updated and results captured
    - Blocker discovered or dependency identified
    - Handoff to another agent/person
  - In the same update cycle, keep the issue body current:
    - Update checklist progress
    - Update notes/decisions sections
    - Add or revise blockers/dependencies
  - Ensure handoff quality:
    - A new contributor should be able to read the issue and resume work immediately
    - Include what changed, what is left, and where to continue
    - Reference repo state when relevant (branch, PR, commit, failing test, artifact)
- Ensure issues are updated and closed when work is complete

### GitHub mutation policy

All GitHub operations (issue create/update/comment, PR review/comment/merge,
branch actions) should use the `gh` CLI by default. If `gh` is unavailable or fails for capability reasons, fall back to GitHub MCP tools for that action.
