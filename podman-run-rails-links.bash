if ! podman image ls | grep rails | grep -q base; then
  echo "Build Base Image ..."
  podman build --no-cache --rm --file Containerfile.Base --tag rails:base .
else
  echo "Base Image present ..."
fi

podman build --no-cache --rm --file Containerfile.Links --tag rails:links .
mkdir -p "$(pwd)/links_storage" "$(pwd)/links_certificates"
podman run --interactive --tty --publish 3111:3000 --volume $(pwd)/links_storage/:/rails/links/storage/:Z,U --volume $(pwd)/links_certificates/:/rails/links/config/certificates/:Z,U rails:links
echo "browse https://localhost:3111/links"
