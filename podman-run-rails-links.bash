if ! podman image ls | grep rails | grep -q base; then
  echo "Build Base Image ..."
  podman build --no-cache --rm --file Containerfile.Base --tag rails:base .
else
  echo "Base Image present ..."
fi

podman build --no-cache --rm --file Containerfile.Links --tag rails:links .
podman run --interactive --tty --publish 3111:3000 rails:links
echo "browse https://localhost:3111/links"
