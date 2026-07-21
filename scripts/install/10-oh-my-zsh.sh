#!/usr/bin/env bash
# oh-my-zsh plus the custom plugins required by home/.zshrc.
# https://ohmyz.sh/
# https://github.com/zsh-users/zsh-autosuggestions
# https://github.com/zsh-users/zsh-syntax-highlighting
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

if [ -d "$TARGET_HOME/.oh-my-zsh" ]; then
    echo "oh-my-zsh already present; skipping install"
else
    as_user 'RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
fi

for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
    if [ ! -d "$TARGET_HOME/.oh-my-zsh/custom/plugins/$plugin" ]; then
        as_user "git clone --depth 1 https://github.com/zsh-users/$plugin ~/.oh-my-zsh/custom/plugins/$plugin"
    fi
done
