# Shared helpers sourced by every install script. Not executable on its own.
#
# Conventions for scripts/install/*.sh:
#   - Idempotent: safe to re-run; each script checks for an existing install first.
#   - Run as root, both during `docker build` and via sudo from bootstrap.sh.
#   - User-scoped installs (oh-my-zsh, tpm, Claude Code, ...) act on TARGET_USER,
#     which defaults to the invoking sudo user, or `vscode` when run as plain root
#     (the docker build case).

set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

TARGET_USER="${TARGET_USER:-${SUDO_USER:-vscode}}"
TARGET_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"

if [ -z "$TARGET_HOME" ]; then
    echo "error: cannot resolve home directory for TARGET_USER=$TARGET_USER" >&2
    exit 1
fi

# Run a command as the target user with a login-ish environment.
as_user() {
    su - "$TARGET_USER" -c "$*"
}
