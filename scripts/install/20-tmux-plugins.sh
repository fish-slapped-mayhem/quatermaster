#!/usr/bin/env bash
# tpm (tmux plugin manager) and the plugins declared in home/.tmux.conf.
# Requires ~/.tmux.conf to be in place (apply-home.sh or a prior COPY).
# https://github.com/tmux-plugins/tpm
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

if [ ! -d "$TARGET_HOME/.tmux/plugins/tpm" ]; then
    mkdir -p "$TARGET_HOME/.tmux/plugins"
    git clone --depth 1 https://github.com/tmux-plugins/tpm "$TARGET_HOME/.tmux/plugins/tpm"
    chown -R "$TARGET_USER:$TARGET_USER" "$TARGET_HOME/.tmux"
    chmod 700 "$TARGET_HOME/.tmux" "$TARGET_HOME/.tmux/plugins"
fi

if [ -f "$TARGET_HOME/.tmux.conf" ]; then
    as_user 'tmux new-session -d -s install; ~/.tmux/plugins/tpm/bin/install_plugins; tmux kill-server'
else
    echo "no ~/.tmux.conf yet; plugin install deferred to the post-apply-home run"
fi
