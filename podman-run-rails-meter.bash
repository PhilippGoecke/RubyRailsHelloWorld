podman build --no-cache --rm --file Containerfile.Meter --tag rails:meter .
mkdir -p "$(pwd)/meter_storage"
podman run --interactive --tty --read-only --cap-drop=ALL --security-opt=no-new-privileges:true --tmpfs /tmp:rw,noexec,nosuid --pids-limit 256 --memory 512m --cpus 1 --publish 3005:3000 --volume $(pwd)/meter_storage/:/rails/demo/storage/:Z,U rails:meter
echo "browse http://localhost:3005/meters"
