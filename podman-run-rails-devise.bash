if ! podman image ls | grep rails | grep -q base; then
  echo "Build Base Image ..."
  podman build --no-cache --rm --file Containerfile.Base --tag rails:base .
else
  echo "Base Image present ..."
fi

podman build --no-cache --rm --file Containerfile.Devise --tag rails:devise .
mkdir $(pwd)/devise_storage/
podman run --interactive --tty --volume $(pwd)/devise_storage/:/rails/demo/storage/ --publish 0.0.0.0:3001:3000 rails:devise
echo "browse https://localhost:3001/?name=Test"
