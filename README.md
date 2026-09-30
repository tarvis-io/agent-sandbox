# Tarvis agent sandbox

Shared Node and Python environment for isolated Tarvis coding sessions and tasks.
The image provides tools; Podman with gVisor or libkrun provides isolation.
No agent credentials, customer files, or workspace data are included.

## Included

- Node.js 24 and npm
- Python 3, `python`/`python3`, pip, and virtual environments
- Git, Bash, curl, CA certificates

Agent CLIs and project dependencies are managed separately. Use a virtual
environment for Python libraries:

```sh
python -m venv /workspace/.venv
/workspace/.venv/bin/python -m pip install openpyxl
```

## Image

`ghcr.io/tarvis-io/agent-sandbox:main` supports Linux ARM64 and AMD64.
Each successful main build also publishes `sha-<full-commit>`.
Production provisioning should pin the multi-architecture manifest digest:

```sh
podman pull ghcr.io/tarvis-io/agent-sandbox@sha256:<manifest-digest>
```

Pull once into the workspace service user's rootless image store, before taking
a Hetzner snapshot or starting sessions. Sessions use the cached image with
`--pull=never`. New image versions are pulled during explicit provisioning or
upgrades, not on each chat. The `io.tarvis.keep=true` label allows provisioning
systems to exclude this toolchain from unused-image cleanup.

## Build and publish

GitHub Actions builds natively on ARM64 and AMD64, then runs offline smoke tests
on both. Only after both pass does it publish the combined manifest. PRs build
and test without publishing. Main pushes and manual workflow runs publish using
GitHub's scoped Actions token; no registry password is stored in this repository.

GHCR package visibility must be set to **public** after the first publication.
Verify anonymous pulls before using the image in unattended provisioning.
The Node base is digest-pinned. Change the recipe/base digest to refresh the
runtime, test it, then update downstream digest pins deliberately.

```sh
docker build -t agent-sandbox:test -f Dockerfile .
docker run --rm -i --network=none agent-sandbox:test sh -s < smoke-test.sh
```
