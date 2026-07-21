#!/usr/bin/env bash
# Starship prompt via the official install script.
# https://starship.rs/
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

if command -v starship > /dev/null 2>&1; then
    echo "starship already present; skipping install"
else
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
fi
