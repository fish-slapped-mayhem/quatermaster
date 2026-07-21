#!/usr/bin/env bash
# Claude Code CLI for AI-assisted coding, installed per-user.
# The native installer places the binary in ~/.local/bin, which is on PATH.
# https://code.claude.com/docs/en/setup
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

if [ -x "$TARGET_HOME/.local/bin/claude" ]; then
    echo "claude already present; skipping install"
else
    as_user 'curl -fsSL https://claude.ai/install.sh | bash'
fi
