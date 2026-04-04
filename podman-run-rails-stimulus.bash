if ! podman image ls | grep rails | grep -q base; then
  echo "Build Base Image ..."
  podman build --no-cache --rm --file Containerfile.Base --tag rails:base .
else
  echo "Base Image present ..."
fi

podman build --no-cache --rm --file Containerfile.Stimulus --tag rails:stimulus .
podman run --interactive --tty --publish 3005:3000 rails:stimulus
echo "browse https://localhost:3005/"
