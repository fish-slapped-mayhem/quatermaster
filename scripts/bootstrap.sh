#!/usr/bin/env bash
# Replicate the Quartermaster environment on a machine where a devcontainer is
# not available (bare Ubuntu/Debian box, WSL, cloud VM).
#
# Runs the same scripts/install/*.sh the Dockerfile runs, in the same order,
# then applies home/ onto $HOME — one source of truth for both paths.
#
# Usage: ./scripts/bootstrap.sh          (prompts for sudo; installs for you)
#        TARGET_USER=alice sudo ./scripts/bootstrap.sh
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    exec sudo TARGET_USER="${TARGET_USER:-$(id -un)}" "$0" "$@"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for script in "$SCRIPT_DIR"/install/[0-9]*.sh; do
    echo "==> $(basename "$script")"
    bash "$script"
    # oh-my-zsh's installer writes its own ~/.zshrc, and later scripts (tmux
    # plugins) need our dotfiles in place — so apply home/ immediately after it.
    if [[ "$script" == *10-oh-my-zsh.sh ]]; then
        echo "==> apply-home.sh"
        bash "$SCRIPT_DIR/apply-home.sh"
    fi
done

# Re-apply at the end so the final state always matches home/ exactly.
echo "==> apply-home.sh"
bash "$SCRIPT_DIR/apply-home.sh"

echo "Quartermaster bootstrap complete. Start a new shell (zsh) to pick up the configuration."
