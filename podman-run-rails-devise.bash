podman build --no-cache --rm --file Containerfile.Devise --tag rails:devise .
podman run --interactive --tty --publish 3000:3000 rails:devise
echo "browse https://localhost:3000/?name=Test"
