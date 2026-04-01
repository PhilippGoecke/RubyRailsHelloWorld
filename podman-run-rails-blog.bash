if ! podman image ls | grep rails | grep -q base; then
  echo "Build Base Image ..."
  podman build --no-cache --rm --file Containerfile.Base --tag rails:base .
else
  echo "Base Image present ..."
fi

#DB_HOST=host.containers.internal
DB_HOST=localhost
DB_USERNAME=rails
DB_PASSWORD=secret
DB_NAME=blog

podman build --no-cache --rm --file Containerfile.Blog --tag rails:blog --env DB_HOST=$DB_HOST --env DB_USERNAME=$DB_USERNAME --env DB_PASSWORD=$DB_PASSWORD --env DB_NAME=$DB_NAME .
podman run --interactive --tty --publish 3002:3000 --env DB_HOST=$DB_HOST --env DB_USERNAME=$DB_USERNAME --env DB_PASSWORD=$DB_PASSWORD --env DB_NAME=$DB_NAME rails:blog
echo "browse https://localhost:3002/"
