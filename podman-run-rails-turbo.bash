if ! podman image ls | grep rails | grep -q base; then
  echo "Build Base Image ..."
  podman build --no-cache --rm --file Containerfile.Base --tag rails:base .
else
  echo "Base Image present ..."
fi

podman build --no-cache --rm --file Containerfile.Turbo --tag rails:turbo .
podman run --interactive --tty --publish 3003:3000 rails:turbo
echo "browse https://localhost:3003/"
