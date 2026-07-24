# Use the official Microsoft Dev Container base image for Ubuntu Noble
FROM mcr.microsoft.com/devcontainers/base:noble

LABEL maintainer="James Brayton" \
        description="A curated development container from Ubuntu Noble with Python and Node.js" \
        version="0.2.0"

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

# All tool installation is delegated to scripts/install/*.sh — the same scripts
# bootstrap.sh runs on bare machines, so the container and non-container paths
# share one source of truth. Each script gets its own RUN for layer caching,
# and each script documents the tool it installs.
ENV TARGET_USER="vscode"
COPY scripts/install/ /opt/quartermaster/scripts/install/

RUN bash /opt/quartermaster/scripts/install/00-apt-packages.sh
RUN bash /opt/quartermaster/scripts/install/10-oh-my-zsh.sh

# home/ mirrors $HOME exactly; apply-home.sh copies it onto /home/vscode and
# fixes ownership and permissions. It runs after oh-my-zsh (whose installer
# would overwrite .zshrc) and before the tmux plugins (which need .tmux.conf).
COPY home/ /opt/quartermaster/home/
COPY scripts/apply-home.sh /opt/quartermaster/scripts/apply-home.sh
RUN bash /opt/quartermaster/scripts/apply-home.sh

RUN bash /opt/quartermaster/scripts/install/20-tmux-plugins.sh
RUN bash /opt/quartermaster/scripts/install/30-starship.sh
RUN bash /opt/quartermaster/scripts/install/40-github-cli.sh
RUN bash /opt/quartermaster/scripts/install/50-uv.sh
RUN bash /opt/quartermaster/scripts/install/51-node.sh

# Set up gem installation directory and add to PATH for all users
ENV GEM_HOME="/home/vscode/gems" \
    PATH="/home/vscode/gems/bin:/home/vscode/.local/bin:/usr/local/bin:${PATH}"

RUN bash /opt/quartermaster/scripts/install/60-ruby-jekyll.sh
RUN bash /opt/quartermaster/scripts/install/70-claude-code.sh
RUN bash /opt/quartermaster/scripts/install/71-copilot-cli.sh

# Make runtime SSH key injection available to every consuming devcontainer:
#   "postCreateCommand": "ssh-runtime-keys"
# Keys arrive via SSH_PRIVATE_KEY_* env vars (never baked into the image).
COPY scripts/ssh-runtime-keys.sh /usr/local/bin/ssh-runtime-keys
RUN chmod 755 /usr/local/bin/ssh-runtime-keys

# Look at Neovim config in the future
# https://medium.com/@edominguez.se/so-i-switched-to-neovim-in-2025-163b85aa0935
