#!/usr/bin/env bash
# Base packages and tools from the Ubuntu archive, plus zsh as the login shell.
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    bat \
    build-essential \
    ca-certificates \
    curl \
    git \
    htop \
    neovim \
    ruby-full \
    software-properties-common \
    sudo \
    tar \
    tmux \
    tree \
    unzip \
    vim \
    wget \
    zsh
rm -rf /var/lib/apt/lists/*

# bat ........................ modern cat with syntax highlighting and Git integration
#                              https://github.com/sharkdp/bat
# build-essential ............ compilers and libraries for building software
# ca-certificates ............ secure HTTPS communication with external services
# curl ....................... HTTP requests, downloads, API interaction
# git ........................ version control            https://git-scm.com/
# htop ....................... interactive process viewer
# neovim ..................... modern Vim experience      https://neovim.io/
# ruby-full .................. Ruby language and standard library (Jekyll)
# software-properties-common . scripts for managing software repositories
# sudo ....................... execute commands as another user
# tar / unzip ................ archive utilities
# tmux ....................... terminal multiplexer
# tree ....................... depth-indented directory listings
# vim ........................ text editor
# wget ....................... command-line downloads
# zsh ........................ the shell everything below assumes
#                              https://www.zsh.org/

chsh -s /usr/bin/zsh "$TARGET_USER"
