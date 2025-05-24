podman build --no-cache --rm -f Containerfile -t rails:demo .
podman run --interactive --tty -p 3000:3000 rails:demo
echo "browse http://localhost:3000/?name=test"
