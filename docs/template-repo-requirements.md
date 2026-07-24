# Template repo requirements

What every new application repository (spun up from `standard-issue`) must
carry itself, because the shared devcontainer image cannot provide it. The
image issues tooling and home-directory configuration identically to everyone;
everything below is identity, secrets, or per-application state — the three
things a shared image must never contain.

## 1. `.devcontainer/devcontainer.json`

Per-repo by definition (it names the workspace). Minimum standard issue:

```jsonc
{
    "name": "<app>",
    "image": "ghcr.io/fish-slapped-mayhem/devcontainer:base",
    "initializeCommand": "docker pull ghcr.io/fish-slapped-mayhem/devcontainer:base",
    "workspaceFolder": "/workspace",
    "workspaceMount": "source=${localWorkspaceFolder},target=/workspace,type=bind,consistency=cached",
    "runArgs": ["--env-file", "${localWorkspaceFolder}/.env"],
    "remoteUser": "vscode",
    // Injects SSH keys from SSH_PRIVATE_KEY_* env vars; no-ops when unset.
    // Guarded so containers from older image builds still start.
    "postCreateCommand": "bash -lc 'command -v ssh-runtime-keys > /dev/null && ssh-runtime-keys || true'"
}
```

## 2. `.env.example` (and a gitignored `.env`)

Secrets are delivered per-machine via a `.env` the repo never tracks. The
template must ship an `.env.example` documenting the variables the app expects
(at minimum `GITHUB_TOKEN` and any `SSH_PRIVATE_KEY_*`; see this repo's
`.env.example` for the format) and must gitignore `.env`.

## 3. `k8s/dev/` — the app's development namespace and workspace access

Cluster RBAC cannot live in a container image, and the Quartermaster only
provisions the shared pieces (`cluster/devpod/`: the `devpod-workspace`
ServiceAccount and the shared `dev` namespace). Each application that deploys
to its own dev namespace must carry the grant in its repo:

```yaml
# k8s/dev/namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: <app>-dev
---
# k8s/dev/devpod-access.yaml
# Lets devcontainer workspaces deploy here. Namespace-scoped `edit` only:
# workloads yes, RBAC and cluster resources no.
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: devpod-workspace-edit
  namespace: <app>-dev
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: edit
subjects:
  - kind: ServiceAccount
    name: devpod-workspace
    namespace: devpod
```

Applied once per app by someone with cluster rights: `kubectl apply -f k8s/dev/`.
Workspaces themselves cannot self-grant (deliberately — `edit` excludes RBAC).

## How workspaces authenticate (no kubeconfig anywhere)

DevPod workspaces run as pods in the cluster under the `devpod-workspace`
ServiceAccount. `kubectl` detects the pod's mounted token automatically when
`~/.kube/config` does not exist, so **do not copy a kubeconfig into a
workspace** — it would only shadow the safer in-cluster identity.

Two behaviors to know:

- **Namespace**: in-cluster kubectl defaults to the pod's own namespace
  (`devpod`). Deploy with an explicit namespace: `kubectl -n <app>-dev apply -f …`.
  To make a default stick, create a thin kubeconfig that reuses the mounted
  token (contexts require a file):

  ```bash
  kubectl config set-cluster in-cluster \
      --server=https://kubernetes.default.svc \
      --certificate-authority=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
  kubectl config set-credentials sa --token="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)"
  kubectl config set-context dev --cluster=in-cluster --user=sa --namespace=<app>-dev
  kubectl config use-context dev
  ```

- **Blast radius**: the token mounted in a workspace is worth `edit` in the
  dev namespaces that granted it — nothing more. That is the point.

## One-time prerequisites (not the template repo's job)

Recorded here so a new machine or cluster can be traced end to end:

- **Cluster**: `kubectl apply -f cluster/devpod/` (this repo) — creates the
  `devpod` namespace, the `devpod-workspace` ServiceAccount, the shared `dev`
  namespace, and its RoleBinding.
- **Each developer machine**: point the DevPod kubernetes provider at the SA:
  `devpod provider set-options kubernetes -o SERVICE_ACCOUNT=devpod-workspace`
  (already reflected in `machine/devpod/config.yaml`).

## Local (non-DevPod) containers and the test cluster

A VS Code devcontainer on your laptop is *outside* the cluster, so the
ServiceAccount mount doesn't exist there. The standing recommendation is a
runtime-injected kubeconfig built around a scoped, time-bound ServiceAccount
token — the same `.env` delivery pattern as SSH keys — never the microk8s
admin config. Not yet implemented; ask the Office.
