#!/usr/bin/env bash
# uv and uvx, installed system-wide via the official standalone installer.
# The Dockerfile and bare-metal bootstrap both use this script so the two
# environments stay identical (the old image used COPY --from=ghcr.io/astral-sh/uv).
# https://docs.astral.sh/uv/
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

if command -v uv > /dev/null 2>&1; then
    echo "uv already present; skipping install"
else
    curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="/usr/local/bin" UV_NO_MODIFY_PATH=1 sh
fi
