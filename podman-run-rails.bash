podman pull debian:trixie-slim
podman inspect --format='{{.RepoDigests}}' debian:trixie-slim >> debian.trixie-slim.sha256
podman build --no-cache --rm --file Containerfile --tag rails:demo .
podman run --interactive --tty --read-only --cap-drop=ALL --security-opt=no-new-privileges:true --tmpfs /tmp:rw,noexec,nosuid --publish 3000:3000 rails:demo
echo "browse http://localhost:3000/?name=test"
