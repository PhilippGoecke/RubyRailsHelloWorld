#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="rails:calendar"
CONTAINER_NAME="calendar"
HOST_PORT="3009"
STORAGE_DIR="$(pwd)/calendar-storage"

podman build --rm --file Containerfile.Calendar --tag "${IMAGE_NAME}" .
mkdir -p "${STORAGE_DIR}"

exec podman run --rm \
  --name "${CONTAINER_NAME}" \
  --read-only \
  --cap-drop=ALL \
  --security-opt=no-new-privileges:true \
  --tmpfs /tmp:rw,noexec,nosuid,nodev \
  --pids-limit 256 \
  --memory 512m \
  --cpus 1 \
  --publish "[::]:${HOST_PORT}:3009" \
  --volume "${STORAGE_DIR}:/rails/storage:Z,U" \
  "${IMAGE_NAME}"
