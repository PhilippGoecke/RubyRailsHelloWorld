podman build --no-cache --rm --file Containerfile.Blog --tag rails:blog .
podman run --interactive --tty --publish 3002:3000 rails:blog
echo "browse https://localhost:3002/"
