# Quartermaster

The Quartermaster's Office maintains, builds, and issues the development environments used throughout Fish Slapped Mayhem. All environments are issued in standard configurations. Requests for non-standard configurations may be submitted in writing and will be considered in the order in which they are ignored.

## What is issued

- **Base images**, built from the Dockerfiles in this repository and published to the registry. Each image contains the tooling a project is expected to need, plus a small allowance of tooling no project has ever needed, retained for reasons of tradition.
- **Tags**, applied with care. `latest` means the most recent issue. It does not mean the best issue. The Office makes no claims regarding "best."

## Requisition procedure

Reference the image in your project's `.devcontainer/devcontainer.json`. New repositories created from `standard-issue` arrive with this paperwork already filed.

## Lost or damaged equipment

Environments that have been broken through misuse should be rebuilt from this repository. Environments broken through ordinary use should also be rebuilt from this repository. The distinction matters to the Office and to no one else.

Stores are open during posted hours. The hours are not posted.
