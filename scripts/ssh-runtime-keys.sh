#!/usr/bin/env bash
# Materialize SSH private keys from environment variables at container start.
#
# Keys must never be baked into the image (published images are copyable
# artifacts), so they arrive as env vars — locally via the gitignored .env file
# (see .env.example), in Codespaces via user secrets. Every variable named
#
#     SSH_PRIVATE_KEY_<NAME>
#
# becomes ~/.ssh/id_<name> (lowercased). Values may be either the raw PEM text
# or base64-encoded (base64 survives .env single-line parsing; encode with:
# base64 < ~/.ssh/id_ed25519 | tr -d '\n').
#
# Baked into the image at /usr/local/bin/ssh-runtime-keys; consuming repos wire
# it as: "postCreateCommand": "ssh-runtime-keys"
#
# No-ops when no such variables are set, so SSH agent forwarding remains the
# zero-config path on hosts that have keys loaded.
set -euo pipefail

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

count=0
while IFS='=' read -r var _; do
    name="${var#SSH_PRIVATE_KEY_}"
    dest="$HOME/.ssh/id_$(echo "$name" | tr '[:upper:]' '[:lower:]')"
    value="${!var}"

    if [ -z "$value" ]; then
        continue
    fi

    if printf '%s' "$value" | grep -q "PRIVATE KEY"; then
        printf '%s\n' "$value" > "$dest"
    else
        printf '%s' "$value" | base64 -d > "$dest"
    fi
    chmod 600 "$dest"
    count=$((count + 1))
    echo "ssh-runtime-keys: wrote $dest"
done < <(env | grep -E '^SSH_PRIVATE_KEY_[A-Za-z0-9_]+=' || true)

if [ "$count" -eq 0 ]; then
    echo "ssh-runtime-keys: no SSH_PRIVATE_KEY_* variables set; relying on agent forwarding"
fi
