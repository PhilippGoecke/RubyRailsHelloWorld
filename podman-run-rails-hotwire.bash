if ! podman image ls | grep rails | grep -q base; then
  echo "Build Base Image ..."
  podman build --no-cache --rm --file Containerfile.Base --tag rails:base .
else
  echo "Base Image present ..."
fi

podman build --no-cache --rm --file Containerfile.Hotwire --tag rails:hotwire .
podman run --interactive --tty --publish 3004:3000 rails:hotwire
echo "browse https://localhost:3004/"
