#!/usr/bin/env bash
# GitHub Copilot CLI for AI-assisted coding, installed per-user
# (gh extensions live in ~/.local/share/gh/extensions/).
# Requires 40-github-cli.sh to have run first.
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

as_user 'curl -fsSL https://gh.io/copilot-install | bash'
