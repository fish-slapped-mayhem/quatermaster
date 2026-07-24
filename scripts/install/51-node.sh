#!/usr/bin/env bash
# Node.js LTS (with npm/npx) system-wide via the NodeSource apt repository.
# The Dockerfile and bare-metal bootstrap both use this script so the two
# environments stay identical (the old image used COPY --from=node:lts, which
# has no bare-machine equivalent).
# https://github.com/nodesource/distributions
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

if command -v node > /dev/null 2>&1; then
    echo "node already present; skipping install"
    exit 0
fi

curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
apt-get install -y --no-install-recommends nodejs
rm -rf /var/lib/apt/lists/*
