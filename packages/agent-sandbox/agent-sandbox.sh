#!/usr/bin/env bash
set -euo pipefail

image="${SANDBOX_IMAGE:-localhost/nixos-agent:latest}"
agent_home="${AGENT_SANDBOX_HOME:-/srv/shared/robot/home}"

if [[ -n "${SANDBOX_IMAGE_ARCHIVE:-}" ]] && ! podman image exists "$image"; then
  podman load --input "$SANDBOX_IMAGE_ARCHIVE"
fi

mkdir -p "$agent_home"
agent_home="$(cd "$agent_home" && pwd -P)"
workdir="$(pwd -P)"

# Codex wants to use bubblewrap by default so we need to give it /proc/ which
# is a bit rubbish.
exec podman run --rm -it \
  --userns=keep-id \
  --cap-drop=all \
  --security-opt=no-new-privileges \
  --security-opt 'unmask=/proc/*' \
  --pids-limit=1024 \
  --memory=16g \
  --cpus=4 \
  -v "$workdir:/workspace:rw" \
  -v "$agent_home:/home/agent:rw" \
  -v agent-nix:/nix:rw,copy,U \
  -w /workspace \
  -e HOME=/home/agent \
  -e NIX_REMOTE=local \
  "$image" "$@"
