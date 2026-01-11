podman build --no-cache --rm --file Containerfile.Devise --tag rails:devise .
podman run --interactive --tty --publish 3001:3000 rails:devise
echo "browse https://localhost:3001/?name=Test"
