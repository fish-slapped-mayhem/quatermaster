# Machine configuration

Host-side configuration that development containers depend on but cannot carry
inside the image: VS Code user settings and DevPod provider inventory.

- `./sync.sh push` — capture this machine's config into the repo. Review the
  diff before committing (settings files can contain tokens).
- `./sync.sh pull` — apply the repo's config to this machine when setting up
  or moving to a new one.

`vscode/` is populated by the first `push` from a configured machine:
`settings.json`, `keybindings.json`, and `extensions.txt`.

`devpod/providers.json` records provider names and option *keys* only — never
option values, which can contain credentials. After `pull`, re-enter secret
options manually (`devpod provider use <name>`).
