#!/usr/bin/env bash
set -euo pipefail

NETWORK=rails-net
MONGO_NAME=mongo
MONGO_EXPRESS_NAME=mongo-express
RAILS_NAME=rails-mongodb
RAILS_IMAGE=localhost/rails-demo:latest

# build the Rails image
podman build --no-cache --rm --file Containerfile.MongoDB --tag "$RAILS_IMAGE" .

# create network if it doesn't exist
podman network exists "$NETWORK" || podman network create "$NETWORK"

# remove old containers if present
podman rm -f "$MONGO_NAME" "$MONGO_EXPRESS_NAME" "$RAILS_NAME" 2>/dev/null || true

# start MongoDB with persistent volume
podman run -d \
  --name "$MONGO_NAME" \
  --network "$NETWORK" \
  -v mongo-data:/data/db \
  docker.io/library/mongo:latest

# start Mongo Express (web UI)
podman run --detach \
  --name "$MONGO_EXPRESS_NAME" \
  --network "$NETWORK" \
  --env ME_CONFIG_MONGODB_SERVER="$MONGO_NAME" \
  --env ME_CONFIG_MONGODB_PORT=27017 \
  --publish 8081:8081 \
  docker.io/library/mongo-express:latest

# start Rails app
podman run --detach \
  --name "$RAILS_NAME" \
  --network "$NETWORK" \
  --env MONGODB_HOST="$MONGO_NAME:27017" \
  --publish 3004:3000 \
  "$RAILS_IMAGE"

echo "Rails app running at http://localhost:3004"
echo "Mongo Express running at http://localhost:8081"

podman logs -f "$RAILS_NAME"
