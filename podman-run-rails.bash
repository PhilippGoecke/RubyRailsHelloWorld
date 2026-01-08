podman build --no-cache --rm --file Containerfile --tag rails:demo .
podman run --interactive --tty --publish 3000:3000 rails:demo
echo "browse http://localhost:3000/?name=test"
