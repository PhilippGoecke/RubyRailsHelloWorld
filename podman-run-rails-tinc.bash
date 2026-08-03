podman build --no-cache --rm --file Containerfile.Tinc --tag rails:tinc .
mkdir -p "$(pwd)/tinc_storage"
podman run --interactive --tty --read-only --cap-drop=ALL --security-opt=no-new-privileges:true --tmpfs /tmp:rw,noexec,nosuid --pids-limit 256 --memory 512m --cpus 1 --publish 3006:3000 --volume $(pwd)/tinc_storage/:/rails/tinc-vpns/storage/:Z,U rails:tinc
echo "browse http://localhost:3006/networks"
