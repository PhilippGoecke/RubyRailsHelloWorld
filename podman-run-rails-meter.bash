podman build --no-cache --rm --file Containerfile.Meter --tag rails:meter .
podman run --interactive --tty --read-only --cap-drop=ALL --security-opt=no-new-privileges:true --tmpfs /tmp:rw,noexec,nosuid --pids-limit 256 --memory 512m --cpus 1 --publish 3005:3000 rails:meter
echo "browse http://localhost:3005/meters"
