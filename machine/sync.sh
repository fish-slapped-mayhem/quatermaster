#!/usr/bin/env bash
# Sync host-side development configuration between this repo and the current
# machine — the config containers depend on but images cannot contain.
#
#   ./machine/sync.sh pull   repo  -> machine (apply versioned config to this host)
#   ./machine/sync.sh push   machine -> repo  (capture this host's config; review
#                                              the diff before committing)
#
# Covers:
#   - VS Code user settings, keybindings, and installed-extension list
#   - DevPod provider inventory (names/options only — never credentials)
#
# push writes files for you to review and commit; it never commits itself.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "$(uname -s)" in
    Darwin) VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User" ;;
    *)      VSCODE_USER_DIR="$HOME/.config/Code/User" ;;
esac

usage() {
    echo "usage: $0 pull|push" >&2
    exit 1
}

[ $# -eq 1 ] || usage

sync_vscode_pull() {
    [ -d "$VSCODE_USER_DIR" ] || { echo "VS Code user dir not found; skipping"; return; }
    for f in settings.json keybindings.json; do
        if [ -f "$REPO_DIR/vscode/$f" ]; then
            cp "$REPO_DIR/vscode/$f" "$VSCODE_USER_DIR/$f"
            echo "applied vscode/$f"
        fi
    done
    if [ -f "$REPO_DIR/vscode/extensions.txt" ] && command -v code > /dev/null 2>&1; then
        while read -r ext; do
            [ -n "$ext" ] && code --install-extension "$ext" --force > /dev/null && echo "extension: $ext"
        done < "$REPO_DIR/vscode/extensions.txt"
    fi
}

sync_vscode_push() {
    [ -d "$VSCODE_USER_DIR" ] || { echo "VS Code user dir not found; skipping"; return; }
    mkdir -p "$REPO_DIR/vscode"
    for f in settings.json keybindings.json; do
        if [ -f "$VSCODE_USER_DIR/$f" ]; then
            cp "$VSCODE_USER_DIR/$f" "$REPO_DIR/vscode/$f"
            echo "captured vscode/$f"
        fi
    done
    if command -v code > /dev/null 2>&1; then
        code --list-extensions > "$REPO_DIR/vscode/extensions.txt"
        echo "captured vscode/extensions.txt"
    fi
}

sync_devpod_push() {
    command -v devpod > /dev/null 2>&1 || { echo "devpod not installed; skipping"; return; }
    mkdir -p "$REPO_DIR/devpod"
    # Names and configured options only. Option VALUES can contain tokens, so
    # they are deliberately not captured.
    devpod provider list --output json |
        python3 -c "import json,sys; d=json.load(sys.stdin); print(json.dumps({n: sorted((p.get('config') or {}).get('options', {}).keys()) for n,p in d.items()}, indent=2))" \
        > "$REPO_DIR/devpod/providers.json"
    echo "captured devpod/providers.json (provider names and option keys only)"
}

sync_devpod_pull() {
    command -v devpod > /dev/null 2>&1 || { echo "devpod not installed; skipping"; return; }
    [ -f "$REPO_DIR/devpod/providers.json" ] || return 0
    python3 -c "import json; print('\n'.join(json.load(open('$REPO_DIR/devpod/providers.json'))))" |
        while read -r provider; do
            devpod provider list --output json | grep -q "\"$provider\"" ||
                { devpod provider add "$provider" || echo "add '$provider' manually (it may need credentials)"; }
        done
}

case "$1" in
    pull) sync_vscode_pull; sync_devpod_pull ;;
    push) sync_vscode_push; sync_devpod_push
          echo "Review with 'git diff' before committing — settings can contain tokens." ;;
    *) usage ;;
esac
