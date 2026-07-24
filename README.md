# Quartermaster

The Quartermaster's Office maintains, builds, and issues the development environments used throughout Fish Slapped Mayhem. All environments are issued in standard configurations. Requests for non-standard configurations may be submitted in writing and will be considered in the order in which they are ignored.

## What is issued

- **Base images**, built from the Dockerfiles in this repository and published to the registry. Each image contains the tooling a project is expected to need, plus a small allowance of tooling no project has ever needed, retained for reasons of tradition.
- **Tags**, applied with care. `latest` means the most recent issue. It does not mean the best issue. The Office makes no claims regarding "best."
- **Standard kit**, being the dotfiles and configuration in `home/`, applied to every environment identically. Personalization is permitted in the sense that it is not prevented.

## Stores layout

| Location | Contents |
| --- | --- |
| `home/` | Mirrors `$HOME` exactly. Everything here — `.zshrc`, `.tmux.conf`, `.config/starship.toml`, `.claude/`, `.ssh/` — lands in the home directory of every issued environment, byte for byte. |
| `scripts/install/` | The tool registry: one idempotent script per tool, run by the Dockerfile and by `bootstrap.sh` alike. A tool not listed here is not issued. |
| `scripts/bootstrap.sh` | Replicates the environment on a bare Ubuntu machine, WSL, or VM where a devcontainer is unavailable. Same scripts, same order, same result. |
| `scripts/apply-home.sh` | Applies `home/` onto `$HOME` with correct ownership and permissions. |
| `scripts/ssh-runtime-keys.sh` | Baked into the image as `ssh-runtime-keys`. Materializes SSH keys from `SSH_PRIVATE_KEY_*` variables at container start. |
| `machine/` | Host-side configuration the image cannot carry: VS Code settings and DevPod provider inventory, synced with `machine/sync.sh push` / `pull`. |
| `cluster/devpod/` | Applied once per cluster (`kubectl apply -f cluster/devpod/`): the `devpod-workspace` ServiceAccount and namespace-scoped RBAC that let in-cluster workspaces deploy to dev namespaces without any kubeconfig being copied anywhere. |
| `docs/` | Paperwork, notably [template-repo-requirements.md](docs/template-repo-requirements.md): what every new application repository must carry itself because the shared image cannot carry it. |

The repository root is reserved for the paperwork of the repository itself. Files destined for a home directory do not loiter there.

## Regarding keys

Private keys are not stored in this repository and are not baked into images. The Office has considered the alternative and declines to be famous for it. Keys are delivered at container start via `SSH_PRIVATE_KEY_*` variables in a machine-local `.env` file (see `.env.example`), or by host SSH agent forwarding, whichever is available. `home/.ssh/` carries only `config` and pinned `known_hosts`.

## Requisition procedure

Reference the image in your project's `.devcontainer/devcontainer.json`. New repositories created from `standard-issue` arrive with this paperwork already filed. To receive SSH keys inside a container, add `"postCreateCommand": "ssh-runtime-keys"` and supply the variables described in `.env.example`.

To outfit a machine that cannot host containers: clone this repository and run `./scripts/bootstrap.sh`. To outfit the host itself (editor settings, provider lists): `./machine/sync.sh pull`. To surrender a machine's configuration back to stores: `./machine/sync.sh push`, then review the diff — the Office audits what it signs for.

## Lost or damaged equipment

Environments that have been broken through misuse should be rebuilt from this repository. Environments broken through ordinary use should also be rebuilt from this repository. The distinction matters to the Office and to no one else.

Stores are open during posted hours. The hours are not posted.
