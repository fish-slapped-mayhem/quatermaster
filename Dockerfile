# Use the official Microsoft Dev Container base image for Ubuntu Resolute
FROM mcr.microsoft.com/devcontainers/base:noble

LABEL maintainer="James Brayton" \
        description="A curated development container from Ubuntu Resolute with Python and Node.js" \
        version="0.1.0"

# Set environment variables for terminal and locale settings
# xterm-256color enables 256 colors in the terminal, which is important for modern
#   terminal applications and themes
# truecolor allows for 24-bit color support, enhancing the visual experience in the
#   terminal
# C.UTF-8 ensures that the container uses UTF-8 encoding, which is essential for proper
#   handling of international characters and symbols
# LC_ALL is set to C.UTF-8 to ensure that all locale categories use UTF-8 encoding,
#   providing consistent behavior across different tools and applications
ENV TERM="xterm-256color" \
    COLORTERM="truecolor" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8"

# Install base packages and tools
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    # bat provides a modern alternative to cat with syntax highlighting 
    # and Git integration
    # https://github.com/sharkdp/bat
    bat \
    # build-essential provides essential tools for building software, including
    # compilers and libraries
    build-essential \
    # ca-certificates ensures that the container can securely communicate
    # with external services over HTTPS
    ca-certificates \
    # curl is a versatile tool for making HTTP requests, essential for downloading
    # files and interacting with APIs
    curl \
    # Git is a version control system for tracking changes in source code
    # https://git-scm.com/
    git \
    # htop is an interactive process viewer for monitoring system resources
    htop \
    # Neovim provides a modern Vim experience with better performance and extensibility
    # https://neovim.io/
    neovim \
    # ruby-full provides the Ruby programming language and its standard library,
    # which is essential for running Ruby applications
    ruby-full \
    # software-properties-common provides scripts for managing software repositories
    software-properties-common \
    # sudo allows a permitted user to execute a command as the superuser or another user
    sudo \
    # tar is a utility for manipulating archive files
    tar \
    # tmux is a terminal multiplexer that allows multiple terminal sessions to be
    # accessed and controlled from a single screen
    tmux \
    # tree is a recursive directory listing program that produces a depth-indented
    # listing of files and directories
    tree \
    # unzip is a utility for extracting compressed files in ZIP format
    unzip \
    # vim is a highly configurable text editor built to enable efficient text editing
    vim \
    # wget is a command-line utility for downloading files from the web
    wget \
    # zsh is a powerful shell that offers improved features and customization options
    # https://www.zsh.org/
    zsh \
    && rm -rf /var/lib/apt/lists/* \
    && chsh -s /usr/bin/zsh vscode \
    && su - vscode -c 'if [ -d "$HOME/.oh-my-zsh" ]; then echo "oh-my-zsh already present; skipping install"; else RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; fi'

# Copy the custom .zshrc configuration for the vscode user
COPY --chown=vscode:vscode .zshrc /home/vscode/.zshrc
RUN chown vscode:vscode /home/vscode/.zshrc \
    && chmod 644 /home/vscode/.zshrc

# Install oh-my-zsh custom plugins required by .zshrc
# https://github.com/zsh-users/zsh-autosuggestions
# https://github.com/zsh-users/zsh-syntax-highlighting
RUN su - vscode -c 'git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions \
    && git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting'

# Preconfigure tmux for vscode user
COPY --chown=vscode:vscode .tmux.conf /home/vscode/.tmux.conf
RUN mkdir -p /home/vscode/.tmux/plugins/tpm \
    && git clone --depth 1 https://github.com/tmux-plugins/tpm /home/vscode/.tmux/plugins/tpm \
    && chown -R vscode:vscode /home/vscode/.tmux \
    && chmod 700 /home/vscode/.tmux \
    && chmod 700 /home/vscode/.tmux/plugins \
    && chmod 600 /home/vscode/.tmux.conf \
    && su - vscode -c 'tmux new-session -d -s install; ~/.tmux/plugins/tpm/bin/install_plugins; tmux kill-server'

# Automatic re-attachment to tmux sessions when connecting via SSH
# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#   tmux attach -t default || tmux new -s default
# fi

# Install Starship prompt via official install script
# https://starship.rs/
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

# Make sure there is a .config directory and set permissions
RUN mkdir -p /home/vscode/.config \
    && chown -R vscode:vscode /home/vscode/.config \
    && chmod 700 /home/vscode/.config

# Copy the custom starship configuration for the vscode user
# https://starship.rs/config/
COPY --chown=vscode:vscode starship.toml /home/vscode/.config/starship.toml
RUN chmod 600 /home/vscode/.config/starship.toml

# Look at Neovim config in the future
# https://medium.com/@edominguez.se/so-i-switched-to-neovim-in-2025-163b85aa0935

# Install GitHub CLI
RUN mkdir -p -m 755 /etc/apt/keyrings \
    && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt update \
    && apt install -y --no-install-recommends gh \
    && rm -rf /var/lib/apt/lists/*

# Install UV
# https://docs.astral.sh/uv/guides/integration/docker/#installing-uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Install Node.js LTS system-wide by copying binaries from the official Node.js image
COPY --from=node:lts /usr/local/bin/node /usr/local/bin/
COPY --from=node:lts /usr/local/lib/node_modules/ /usr/local/lib/node_modules/
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -s /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx

# Set up gem installation directory and add to PATH for all users
ENV GEM_HOME="/home/vscode/gems" \
    PATH="/home/vscode/gems/bin:/home/vscode/.local/bin:/usr/local/bin:${PATH}"

# Install Jekyll and Bundler for GitHub Pages documentation
RUN mkdir -p /home/vscode/gems \
    && chown -R vscode:vscode /home/vscode/gems \
    && su - vscode -c 'export GEM_HOME=/home/vscode/gems PATH=/home/vscode/gems/bin:$PATH && gem install jekyll bundler'

# Install Claude Code CLI for AI-assisted coding as the vscode user
# The native installer places the binary in ~/.local/bin, which is already on PATH
# https://code.claude.com/docs/en/setup
RUN su - vscode -c 'curl -fsSL https://claude.ai/install.sh | bash'

# Configure ClaudeCode CLI to be pre-onboarded to avoid onboarding prompts
# This helps avoid issues when using the long lived OAUTH token
RUN echo '{"hasCompletedOnboarding":true}' > /home/vscode/.claude.json \
    && chown vscode:vscode /home/vscode/.claude.json

# Install GitHub Copilot CLI for AI-assisted coding as the vscode user
# gh extensions are installed per-user (~/.local/share/gh/extensions/)
RUN su - vscode -c 'curl -fsSL https://gh.io/copilot-install | bash'
