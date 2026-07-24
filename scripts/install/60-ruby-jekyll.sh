#!/usr/bin/env bash
# Jekyll and Bundler for GitHub Pages documentation, installed into a
# per-user gem directory ($TARGET_HOME/gems).
#
# PATH note: the Dockerfile exports GEM_HOME and PATH via ENV for containers;
# on a bare machine, home/.zshrc is expected to provide the equivalent
# (~/gems/bin and ~/.local/bin on PATH).
# https://jekyllrb.com/
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

mkdir -p "$TARGET_HOME/gems"
chown -R "$TARGET_USER:$TARGET_USER" "$TARGET_HOME/gems"
as_user "export GEM_HOME=\$HOME/gems PATH=\$HOME/gems/bin:\$PATH && gem list -i jekyll > /dev/null 2>&1 || gem install jekyll bundler"
