#!/usr/bin/env bash
# Apply the repo's home/ tree onto the target user's $HOME.
#
# home/ mirrors $HOME exactly, so installation is a straight copy followed by
# ownership and permission fixes. Used by the Dockerfile (during image build)
# and by bootstrap.sh (on bare machines). Run as root.
#
# Copies overwrite existing files but never delete anything already in $HOME.
source "$(dirname "${BASH_SOURCE[0]}")/install/lib.sh"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cp -R "$REPO_ROOT/home/." "$TARGET_HOME/"

# Own only what home/ provides, not the whole of $HOME.
(cd "$REPO_ROOT/home" && find . -mindepth 1 -maxdepth 1) | while read -r entry; do
    chown -R "$TARGET_USER:$TARGET_USER" "$TARGET_HOME/${entry#./}"
done

chmod 644 "$TARGET_HOME/.zshrc"
chmod 600 "$TARGET_HOME/.tmux.conf"

chmod 700 "$TARGET_HOME/.config"
chmod 600 "$TARGET_HOME/.config/starship.toml"

# SSH is strict about these: the directory must be 700 and its files 600,
# or the client refuses to use them.
chmod 700 "$TARGET_HOME/.ssh"
find "$TARGET_HOME/.ssh" -type f -exec chmod 600 {} +

chmod 700 "$TARGET_HOME/.claude"

# Pre-onboard Claude Code to avoid onboarding prompts, which helps when using
# a long-lived OAuth token. ~/.claude.json accumulates tokens and history at
# runtime, so it is generated here rather than tracked in the repo.
if [ ! -f "$TARGET_HOME/.claude.json" ]; then
    echo '{"hasCompletedOnboarding":true}' > "$TARGET_HOME/.claude.json"
    chown "$TARGET_USER:$TARGET_USER" "$TARGET_HOME/.claude.json"
    chmod 600 "$TARGET_HOME/.claude.json"
fi
