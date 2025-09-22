podman build --no-cache --rm -f Containerfile.Devise -t rails:devise .
podman run --interactive --tty -p 3000:3000 rails:devise
echo "browse https://localhost:3000/?name=test"
